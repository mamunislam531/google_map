

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class AddressToLatLngDemo extends StatefulWidget {
  const AddressToLatLngDemo({super.key});

  @override
  _AddressToLatLngDemoState createState() => _AddressToLatLngDemoState();
}

class _AddressToLatLngDemoState extends State<AddressToLatLngDemo> {
  final TextEditingController _addressController = TextEditingController();
  String _result = '';
  double lat = 0.00;
  double long = 0.00;
  String address = "";

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _convertAddressToLatLng() async {
    String address = _addressController.text;
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        lat = location.latitude;
        long = location.longitude;
        setState(() {
          _result =
          'Latitude: ${location.latitude}, Longitude: ${location.longitude}';
        });
      } else {
        setState(() {
          _result = 'No location found for the address';
        });
      }
    } catch (e) {
      setState(() {
        _result = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address to Lat Lon Demo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Enter Address',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _convertAddressToLatLng,
              child: Text('Convert to Lat Lon'),
            ),

            SizedBox(height: 16.0),
            Text(
              _result,
              style: TextStyle(fontSize: 16.0),
            ),
            ElevatedButton(
              onPressed: _getAddress,
              child: Text('Location to Address'),
            ),
            Text(
              address,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
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
}