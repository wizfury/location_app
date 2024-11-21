import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ...

void main(List<String> args) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  permissions();
  runApp(MyApp());
}

void permissions() {
  Geolocator.checkPermission().then((LocationPermission permission) {
    if (permission == LocationPermission.denied) {
      Geolocator.requestPermission().then((LocationPermission permission) {
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
        } else {}
      });
    } else if (permission == LocationPermission.deniedForever) {
    } else {}
  });
}

void getlocation() {
  Geolocator.getCurrentPosition().then((Position position) {
    CollectionReference locations =
        FirebaseFirestore.instance.collection('Location');
    locations.add({
      'location': position,
    }).then((DocumentReference reference) => print('Location added: ${reference.id}')).catchError((error)=>print("${error}"));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    

    //Sample Coordinates..
    LatLng newyork = LatLng(40.7128, -74.0060);
    LatLng paris = LatLng(48.8566, 2.3522);

    //Calculating distance
    final double distance = Geolocator.distanceBetween(
        newyork.latitude, newyork.longitude, paris.latitude, paris.longitude);

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Locations"),
          ),
          body: Center(
            child: Column(
              children: [
                Text(
                    "Latitude: ${newyork.latitude}\t Longitude: ${newyork.longitude}\n Latitude: ${paris.latitude}\t Longitude: ${paris.longitude}"),
                Text("Distance: ${(distance / 1000).round()} km"),
                ElevatedButton(onPressed: getlocation, child: Text("Push location"))
              ],
            ),
          )),
    );
  }
}
