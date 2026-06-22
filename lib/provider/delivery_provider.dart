//Delivery Provider Screen
import 'dart:async';

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
  int currentStep = 0;
  LatLng? _currentDeliveryBoyPosition;
  Timer? animationTimer;
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

      }

      // stop animation when destination is reached
      void markDestinationReached() {}

      // mark order as being delivered
      void markAdDelivered() {}

     // complete the delivery process
     void completeDelivery() {}

    // setup route points from pre-calculated data
     void _generateRoutePoints() {}

    // create polyline and marks for google maps
    void _setupMapOverlays() {}

     //Update or create delivery boy markers with current position
    void _updateDeliveryBoyMarker() {}


    // handle when animation reached destination
    void _DestinationReached() {}

    // stop the movement animation timer
    void _stopAnimation() {}

    // reset all delivery data to initial state
    void reseDelivery() {}

   // clean up resources when provider is disposed
   @override
   void dispose() {
     _stopAnimation();
     super.dispose();
   }
}