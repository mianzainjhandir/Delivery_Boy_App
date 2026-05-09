import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationProvider extends ChangeNotifier {
  LatLng _currentLocation = LatLng(37.7749, 122.4194);
  bool _isLoading = true;
  String _errorMessage = " ";

  //Public getters to access the private variables

  LatLng get currentLocation => _currentLocation;

  bool get isLoading => _isLoading;

  String get errorMessage => _errorMessage;

  CurrentLocationProvider() {}

  // Main Function to get live location

  Future<void> getCurrentLocation() async {
    try {
      // Check if Location permission is granted
      LocationPermission permission = await Geolocator.checkPermission();
      if(permission == LocationPermission.denied){
        // Request permission if denied
        permission = await Geolocator.requestPermission();
        if(permission == LocationPermission.denied){
          _errorMessage = "Location permission denied. Use default location.";
          _isLoading = false;
          notifyListeners();
          return;
        }
      }
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if(!serviceEnabled){
        _errorMessage = "Location services are disabled.";
        _isLoading = false;
        notifyListeners();
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high
      );
      //Success - update location and clear loading state and error message
      _currentLocation = LatLng(position.latitude, position.longitude);
      _isLoading = false;
      _errorMessage = " ";
      notifyListeners();
    } catch (e){
      //handle any errors that occur during location retrieval
      _errorMessage = "Failed to get location: ${e.toString()}. Use default location.";
      _isLoading = false;
      notifyListeners();
      print(e.toString());
    }
  }

  //Public method to manually refresh location
  Future<void> refreshLocation() async {
    _isLoading = true;
    notifyListeners();
    await getCurrentLocation();
  }
}
