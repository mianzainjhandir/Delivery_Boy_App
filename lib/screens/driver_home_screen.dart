import 'package:delivery_boy_app/provider/current_location_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  // Create marker for current location
  Set<Marker> _buildMarkers(LatLng currentLocation) {
    return {
      Marker(
        markerId: const MarkerId('current_location'),
        position: currentLocation,
        infoWindow: const InfoWindow(
          title: 'Current Location',
          snippet: "You are here",
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRed,
        ),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CurrentLocationProvider>(
        builder: (context, locationProvider, child) {

          // Show loading indicator while fetching location
          if (locationProvider.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 15),
                  Text("Getting your location..."),
                ],
              ),
            );
          }

          // Show error message if location retrieval failed
          if (locationProvider.errorMessage.trim().isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(locationProvider.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            });
          }

          Size size = MediaQuery.of(context).size;

          return Stack(
            children: [

              // Google Map
              GoogleMap(
                onMapCreated: _onMapCreated,
                markers:
                _buildMarkers(locationProvider.currentLocation),

                initialCameraPosition: CameraPosition(
                  target: locationProvider.currentLocation,
                  zoom: 15,
                ),

                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
              ),

              // Bottom Text
              if (locationProvider.errorMessage.isEmpty)
              // Online Button UI
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: size.height * 0.12,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Center(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: 200,
                          height: 38,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.red,
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              children: [

                                // Online Button
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius:
                                      BorderRadius.circular(30),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "Online",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),

                                const Expanded(
                                  child: SizedBox(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}