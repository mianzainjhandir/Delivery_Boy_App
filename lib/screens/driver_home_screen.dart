import 'package:delivery_boy_app/provider/current_location_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  GoogleMapController? mapController;
  bool isOnline = true;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  //create Marks for current location
  Set<Marker> _buildMarkers(LatLng currentLocation) {
    return {
      Marker(
        markerId: MarkerId('current_location'),
        position: currentLocation,
        infoWindow: InfoWindow(
            title: ' Current Location',
          snippet: "You are here"
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    };
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CurrentLocationProvider>(builder: (context, locationProvider, chiild){
        //show loading indicator while fetching location
        if(locationProvider.isLoading){
          return Center(
            child: Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 15,),
                Text("Getting your location..."),
              ],
            ),
          );
        }
        //show error message if location retrieval failed
        if(locationProvider.errorMessage.trim().isNotEmpty){
          WidgetsBinding.instance.addPersistentFrameCallback((_) {
            showAppSnackbar (
                context : context,
                type: SnackBarType.error,
              discripton: locationProvider.errorMessage,
            );
          });
        }
        Size size = MediaQuery.of(context).size;
        return Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              markers: _buildMarkers(locationProvider.currentLocation),
                initialCameraPosition: CameraPosition(
                    target: locationProvider.currentLocation,
                    zoom: 15
                ),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
            ),
            if(locationProvider.errorMessage.isEmpty)
            Align(alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.all(15),
            ),)
          ],
        );
      })
    );
  }

}
