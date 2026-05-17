import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationProvider extends ChangeNotifier {
  LatLng _currentLocation = const LatLng(37.7749, -122.4194);
  bool _isLoading = true;
  String _errorMessage = "";

  // Getters
  LatLng get currentLocation => _currentLocation;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Constructor
  CurrentLocationProvider() {
    getCurrentLocation();
  }

  // Get current location
  Future<void> getCurrentLocation() async {
    try {
      print("Getting location...");
      bool serviceEnabled;
      LocationPermission permission;
      // Check if location service enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _errorMessage = "Location services are disabled.";
        _isLoading = false;
        notifyListeners();
        return;
      }

      // Check permission
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _errorMessage = "Location permission denied.";
          _isLoading = false;
          notifyListeners();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _errorMessage =
        "Location permission permanently denied.";
        _isLoading = false;
        notifyListeners();
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print(position.latitude);
      print(position.longitude);
      // Update location
      _currentLocation = LatLng(
        position.latitude,
        position.longitude,
      );
      _errorMessage = "";
    } catch (e) {
      _errorMessage = "Failed to get location: $e";
      print(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Refresh location
  Future<void> refreshLocation() async {
    _isLoading = true;
    notifyListeners();
    await getCurrentLocation();
  }
}