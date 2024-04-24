import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';

class AddressToLatLng extends StatefulWidget {
  const AddressToLatLng({super.key});

  @override
  State<AddressToLatLng> createState() => _AddressToLatLngState();
}

class _AddressToLatLngState extends State<AddressToLatLng> {
TextEditingController addressController = TextEditingController();

 Future<void> getLatLng() async {

    GeoCode geoCode = GeoCode();
    try {
      Coordinates coordinates = await geoCode.forwardGeocoding(address: "road 22 ,Sector 14,Uttara ,Dhaka");

      print("Latitude: ${coordinates.latitude}");
      print("Longitude: ${coordinates.longitude}");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address to Lat Lng"),
      ),
      body: Center(
        child: Column(children: [
          TextField(
            controller: addressController,
          decoration: InputDecoration(
            labelText: "Address",
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(),
          ),
          ),


          ElevatedButton(onPressed: ()async{
            print("=========  1  ==============");
           await getLatLng();
           print("============  2  ===========");
          }, child : Text("Sent"))
        ]),
      ),
    );
  }
}
