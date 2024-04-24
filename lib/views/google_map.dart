import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyLocationOnGoogleMap extends StatefulWidget {
  const MyLocationOnGoogleMap({super.key, required this.latitude, required this.longitude});
  final double latitude;
  final double longitude;

  @override
  State<MyLocationOnGoogleMap> createState() => _MyLocationOnGoogleMapState();
}

class _MyLocationOnGoogleMapState extends State<MyLocationOnGoogleMap> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  double lat = 0.00;
  double lng = 0.00;

  receiveLatLng() {
    lat = widget.latitude;
    lng = widget.longitude;
    setState(() {});
  }

  @override
  void initState() {
    receiveLatLng();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("My Location On Google Map"),
      ),
      body: Center(
        child: Column(
          children: [
            Card(
              child: Row(
                children: [
                  Text("Lat : $lat"),
                  Text("Lat : $lng"),
                ],
              ),
            ),
            Expanded(
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat, lng),
                  zoom: 19.5,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: {Marker(markerId: const MarkerId("value"), position: LatLng(lat, lng))},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
