import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:real_time_location_tracking/function/get_lat_long.dart';
import 'package:real_time_location_tracking/function/get_location_permission.dart';
import 'package:real_time_location_tracking/views/google_map.dart';
import 'package:real_time_location_tracking/views/searchLocationUsingAddress.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double latitude = 0.00;
  double longitude = 0.00;
  String address = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map Route Page"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Latitude : $latitude"),
                          Text("Longitude : $longitude"),
                          SizedBox(child: Text("Address : $address")),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 100),
            ElevatedButton(
                onPressed: () async {
                  await GetLocationPermission().getLocationPermission();
                },
                child: const Text("Get Permission")),
            ElevatedButton(
                onPressed: () async {
                  await _getLatLng();
                },
                child: const Text("Get Location Lat Long")),
            ElevatedButton(
                onPressed: () async {
                  await _getAddress();
                },
                child: const Text("Get Location Address")),
            ElevatedButton(
                onPressed: () async {
                  if (latitude == 0 || longitude == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Get Lat Long")));
                    return;
                  }
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyLocationOnGoogleMap(latitude: latitude, longitude: longitude)));
                },
                child: const Text("See My Current Location on Map")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchLocationUsingAddress()));
                },
                child: const Text("search Location using address"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _resetData();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  // get Lat Long
  _getLatLng() async {
    Position position = await GetLatLong().getLatLong();
    latitude = position.latitude;
    longitude = position.longitude;
    setState(() {});
  }

  // get Address
  _getAddress() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> addresses = await placemarkFromCoordinates(position.latitude, position.longitude);
    var data = addresses[1];
    address = "${data.subThoroughfare},"
        "${data.thoroughfare},"
        "${data.subLocality},"
        "${data.locality},"
        "${data.postalCode},"
        "${data.country}";
  print(address);
    setState(() {});
  }

  // Reset All Data
  _resetData() {
    latitude = 0;
    longitude = 0;
    address = "";
    setState(() {});
  }
}
