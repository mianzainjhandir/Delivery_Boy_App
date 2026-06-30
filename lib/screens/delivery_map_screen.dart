import 'package:delivery_boy_app/provider/delivery_provider.dart';
import 'package:delivery_boy_app/utills/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class DeliveryMapScreen extends StatefulWidget {
  const DeliveryMapScreen({super.key});

  @override
  State<DeliveryMapScreen> createState() => _DeliveryMapScreenState();
}

class _DeliveryMapScreenState extends State<DeliveryMapScreen> {

  GoogleMapController? _mapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Consumer<DeliveryProvider>(
          builder: (context, provider, child){
        return Stack(
          children: [
            // Google Map
            _buildGoogleMap(provider),
            // Order Status Widget layer - show delivery progress and action buttons
            Consumer<DeliveryProvider>(builder: (context, provider, child){
              if(provider.currentOrder == null) return SizedBox();

              // Show Order on the way status widget when order is accepted
              if(provider.status == DeliveryStatus.rejected){
                return SizedBox();
              }
              return Align(
                alignment: Alignment.bottomCenter,
                child: Padding(padding: EdgeInsets.all(1)

                ),
              );
            }
            )

          ],
        );
      }),
    );
  }

  //Build and configure the google map widget
  Widget _buildGoogleMap(DeliveryProvider provider){
    return GoogleMap(
      onMapCreated: (GoogleMapController controller){
        _mapController = controller;
        if(provider.currentOrder != null){
          _moveToLocation(provider.currentOrder!.pickupLocation);
        }
      },
      initialCameraPosition: CameraPosition(target: LatLng(27.7033, 85.3206), zoom: 14),
     markers: _buildMarkers(provider),
     polylines: _buildPolylines(provider),
     zoomControlsEnabled: false,
      myLocationButtonEnabled: false,

    );
  }

  //Create Map Markers for pickup delivery and drop locations....
  Set<Marker> _buildMarkers(DeliveryProvider provider){
    Set<Marker> markers = {};

    if(provider.currentOrder != null){
      markers.add(
          Marker(markerId: MarkerId("pickUp"),
            position: provider.currentOrder!.pickupLocation ?? LatLng(0.0, 0.0),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
            infoWindow: InfoWindow(title: "Pickup Location"),
          )
      );
      markers.add(
          Marker(markerId: MarkerId("delivery"),
            position: provider.currentOrder!.deliveryLocation?? LatLng(0.0, 0.0),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            infoWindow: InfoWindow(title: "Delivery Location"),
          )
      );
      //delivery boy markers when moving
      if(provider.currentDeliveryBoyPosition != null){
        markers.add(
            Marker(markerId: MarkerId("delivery"),
              position: provider.currentDeliveryBoyPosition ?? LatLng(0.0, 0.0),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
              infoWindow: InfoWindow(title: "Delivery Boy"),
            )
        );
        // move camera to follow delivery boy
        _moveToLocation(provider.currentDeliveryBoyPosition!);
      }
    }
    return markers;
  }
  // Create route line to show my path between locations
  Set <Polyline> _buildPolylines(DeliveryProvider provider){
    Set<Polyline> polylines = {};

    //  show polyline when order is accepted
    if(provider.routePoints.isEmpty && provider.status != DeliveryStatus.waitingForAcceptance && provider.status != DeliveryStatus.rejected){
      polylines.add(
        Polyline(
          polylineId: PolylineId("route"),
          points: provider.routePoints,
          color: buttonMainColor,
          width: 6,
        )
      );
    }
    return polylines;
  }


  void _moveToLocation(LatLng location){
    _mapController?.animateCamera(CameraUpdate.newLatLngZoom(location, 14));
  }
}
