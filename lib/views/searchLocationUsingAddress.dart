import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import 'google_map.dart';

class SearchLocationUsingAddress extends StatefulWidget {
  const SearchLocationUsingAddress({super.key});

  @override
  State<SearchLocationUsingAddress> createState() => _SearchLocationUsingAddressState();
}

class _SearchLocationUsingAddressState extends State<SearchLocationUsingAddress> {
  TextEditingController addressController = TextEditingController(text: "House-36,Road Number 3,Uttara,Dhaka,1230,Bangladesh");
  double latitude = 0.00;
  double longitude = 0.00;
  String address = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Searh Location Using Address"),
      ),
      body: Center(
        child: Column(
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
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
                labelText: "Enter Address",
              ),
            ),
            const SizedBox(
              height: 20
            ),
            ElevatedButton(
              onPressed: () async {
                _getLatLong(address: addressController.text);
              },
              child: Text("Get Lat Long"),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (latitude == 0 || longitude == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Get Lat Long")));
                    return;
                  }
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyLocationOnGoogleMap(latitude: latitude, longitude: longitude)));
                },
                child: const Text("See My Current Location on Map")),
          ],
        ),
      ),
    );
  }

  _getLatLong({required String address}) async {
    List<Location> locations = await locationFromAddress(address);
    print("============  $locations");
    latitude = locations[0].latitude;
    longitude = locations[0].longitude;
     setState(() {});
  }
}
