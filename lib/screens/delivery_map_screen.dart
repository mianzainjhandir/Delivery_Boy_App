import 'package:delivery_boy_app/provider/delivery_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class DeliveryMapScreen extends StatelessWidget {
  const DeliveryMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Consumer<DeliveryProvider>(
          builder: (context, provider, child){
        return Stack(
          children: [

          ],
        );
      }),
    );
  }
  //Build and configure the google map widget
  Widget _buildGoogleMap(DeliveryProvider provider){
    return GoogleMap(initialCameraPosition: CameraPosition(target: LatLng(27.7033, 85.3206), zoom: 14),
     zoomControlsEnabled: false,
      myLocationButtonEnabled: false,

    );
  }
  //Create Map Markers for pickup delivery and drop locations

}
