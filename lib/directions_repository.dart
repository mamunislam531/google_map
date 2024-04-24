import 'package:dio/dio.dart';
class DirectionsRepository {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  Future<void> getDirections({
    // required LatLng origin,
    // required LatLng destination,
    required double origin,
    required double destination,
  }) async {
    final response = await Dio().get(
      _baseUrl,
      queryParameters: {
        'origin': 'origin=place_id:ChIJ3S-JXmauEmsRUcIaWtf4MzE',
        'destination': '$origin,$destination',
        'key': "AIzaSyDLKIzdDug9YFY-Mo57ic4WPoFyDuo38xk",
      },
    );
    print("------  ${response.data}  ----------------");
    if (response.statusCode == 200) {}
  }
}
