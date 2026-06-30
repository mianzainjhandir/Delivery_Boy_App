//Delivery Provider Screen
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/order.dart';

enum DeliveryStatus {
  waitingForAcceptance,
  orderAccepted,
  pickingUp,
  destinationReached,
  enRoute,
  markingAsDelivered,
  delivered,
  rejected,
}

class DeliveryProvider extends ChangeNotifier {

  DeliveryStatus _status = DeliveryStatus.waitingForAcceptance;
  OrderModel? _currentOrder;
  List<LatLng> _routePoints = [];
  int _currentStep = 0;
  LatLng? _currentDeliveryBoyPosition;
  Timer? _animationTimer;
  final Set<Polyline> _polylines = {};
  final Set<Marker> _markers = {};

  //Public Getters to access private variables;

  DeliveryStatus get status => _status;
  OrderModel? get currentOrder => _currentOrder;
  List<LatLng> get routePoints => _routePoints;
  LatLng? get currentDeliveryBoyPosition => currentDeliveryBoyPosition;
  Set<Polyline> get polylines => _polylines;
  Set<Marker> get markers => _markers;

  // Sample Hardcoded route points

   static const List<LatLng> _perCalculatedRoute = [
     LatLng(27.7033, 85.3066), // Starting point (Kathmandu Durbar Square)
     LatLng(27.7020, 85.3078),
     LatLng(27.7005, 85.3101),
     LatLng(27.6980, 85.3135),
     LatLng(27.6950, 85.3160),
     LatLng(27.6915, 85.3190),
     LatLng(27.6880, 85.3220),
     LatLng(27.6845, 85.3235),
     LatLng(27.6810, 85.3245),
     LatLng(27.6780, 85.3250),
     LatLng(27.6750, 85.3252),
     LatLng(27.6710, 85.3250), // End point (Patan Durbar Square)
   ];
   // Initializing new order with demo data...

    void initializeOrder (){
      _currentOrder = OrderModel(
        id: "order123",
        customerName: "John Doe",
        customerPhone: "+1234567890",
        item: "Tender Coconut {Normal}",
        quantity: 4,
        price: 320,
        pickupLocation: LatLng(27.7033, 85.3066), // Kathmandu Durbar Square
        deliveryLocation: LatLng(27.6710, 85.3250), // Patan Durbar Square
        pickupAddress: "Kathmandu Durbar Square, Kathmandu, Nepal",
        deliveryAddress: "Patan Durbar Square, Lalitpur, Nepal",
      );
      _routePoints = _perCalculatedRoute;
      notifyListeners();
    }
    // Accept order and start delivery process

     void acceptOrder() {
      _status = DeliveryStatus.orderAccepted;
      notifyListeners();

      Timer(Duration(seconds: 5), (){

        _generateRoutePoints();
        _setupMapOverlays();
        notifyListeners();
      });
     }

     //Reject Order and clear all data

      void rejectOrder() {
        _status = DeliveryStatus.rejected;
        _routePoints.clear();
        _currentDeliveryBoyPosition = null;
        _polylines.clear();
        _markers.clear();
        _stopAnimation();
        notifyListeners();
      }
      // start pickup process - Move delivery boy to pickup location
       void startPickup() {
      _status = DeliveryStatus.pickingUp;
      _currentDeliveryBoyPosition = _currentDeliveryBoyPosition;
      _updateDeliveryBoyMarker();
       }

      // mark order as picked up and star delivery animation
      void markAsPickedUp() {
      _status = DeliveryStatus.enRoute;
      _startDeliverySimulation();
      }

      // stop animation when destination is reached
      void markDestinationReached() {
      _status = DeliveryStatus.destinationReached;
      _stopAnimation();
      notifyListeners();
      }

      // mark order as being delivered
      void markAdDelivered() {
      _status = DeliveryStatus.markingAsDelivered;
      notifyListeners();
      }

     // complete the delivery process
     void completeDelivery() {
      _status = DeliveryStatus.delivered;
      notifyListeners();
     }

    // setup route points from pre-calculated data
     void _generateRoutePoints() {
      _routePoints = _perCalculatedRoute;
      _currentDeliveryBoyPosition = _routePoints[0];
      _currentStep = 0;
     }

    // create polyline and marks for google maps
    void _setupMapOverlays() {
      _polylines.add(
        Polyline(polylineId: PolylineId("deliveryRoute"),
        points: routePoints,
          color: Colors.blue,
          width: 5,

        )
      );

      // Add green marker for pickup location
      _markers.add(
        Marker(markerId: MarkerId("pickUp"),
        position: _currentOrder!.pickupLocation?? LatLng(0.0, 0.0),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: InfoWindow(title: "Pickup Location"),
        )
      );
      // Add red marker for delivery location
      _markers.add(
          Marker(markerId: MarkerId("delivery"),
            position: _currentOrder!.deliveryLocation,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
            infoWindow: InfoWindow(title: "Delivery Location"),
          )
      );
      _updateDeliveryBoyMarker();
    }

     //Update or create delivery boy markers with current position
    void _updateDeliveryBoyMarker() {
      _markers.removeWhere((m) => m.markerId.value == "deliveryBoy");
      if(_currentDeliveryBoyPosition != null){
        _markers.add(
            Marker(markerId: MarkerId("deliveryBoy"),
              position: _currentDeliveryBoyPosition!,
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
              rotation: _calculateBearing(),
              infoWindow: InfoWindow(title: "Delivery Partner"),
            )
        );

      }
    }
  // Calculate bearing between two LatLng points to rotate the delivery
     double _calculateBearing(){
      // Return 0 if start or no route points
       if(_currentStep == 0 || _routePoints.isEmpty) return 0;
       // Get previous and current points
       LatLng previousPoint = _routePoints[_currentStep -1];
        LatLng currentPoint = _routePoints[_currentStep];
        // Convert to raduans for calculation
       double lat1 = previousPoint.latitude * pi / 180;
       double lon1 = previousPoint.longitude * pi / 180;
        double lat2 = currentPoint.latitude * pi / 180;
        double lon2 = currentPoint.longitude * pi / 180;

        double y = sin(lon2 - lon1) * cos(lat2);
        double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(lon2 - lon1);

        return( atan2(y, x) * 180 / pi + 360) % 360;
     }
     // Start animated movement along the route
     void _startDeliverySimulation(){
      const duration = Duration(milliseconds: 300);
      _animationTimer = Timer.periodic(duration, (timer){
        if(_currentStep < _routePoints.length -1){
          _currentStep++;
          _currentDeliveryBoyPosition = _routePoints[_currentStep];
          _updateDeliveryBoyMarker();
          notifyListeners();
        } else {
          _stopAnimation();
          _DestinationReached();
        }
      });
     }
    // handle when animation reached destination
    void _DestinationReached() {
      _status = DeliveryStatus.destinationReached;
      notifyListeners();
    }

    // stop the movement animation timer
    void _stopAnimation() {
      _animationTimer?.cancel();
      _animationTimer = null;
    }

    // reset all delivery data to initial state
    void reuseDelivery() {
      _stopAnimation();
      _status = DeliveryStatus.waitingForAcceptance;
      _routePoints = [];
      _polylines.clear();
      _markers.clear();
      _currentStep = 0;
      _currentDeliveryBoyPosition = null;
      initializeOrder();
      notifyListeners();
    }

   // clean up resources when provider is disposed
   @override
   void dispose() {
     _stopAnimation();
     super.dispose();
   }
}