
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationProvider extends ChangeNotifier{
LatLng  _currentLocation = LatLng(37.7749, 122.4194);
bool _isLoading = true;
String _errorMessage = " ";

//Public getters to access the private variables

LatLng get currentLocation => _currentLocation;
bool get isLoading => _isLoading;
String get errorMessage => _errorMessage;

CurrentLocationProvider(){

}
}