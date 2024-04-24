import 'package:geolocator/geolocator.dart';

class GetLocationPermission {
  getLocationPermission() async {
    await Geolocator.requestPermission();
  }
}
