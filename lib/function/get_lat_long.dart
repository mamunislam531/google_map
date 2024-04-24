import 'package:geolocator/geolocator.dart';

class GetLatLong {
  getLatLong() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
    return position;
  }
}
