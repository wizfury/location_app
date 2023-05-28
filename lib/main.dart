import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    //Sample Coordinates..
    LatLng newyork = LatLng(40.7128, -74.0060);
    LatLng paris = LatLng(48.8566, 2.3522);

    //Calculating distance
    final double distance = Geolocator.distanceBetween(newyork.latitude,newyork.longitude,paris.latitude,paris.longitude);

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Locations"),
          ),
          body: Column(
            children: [
                  Text(
                      "Latitude: ${newyork.latitude}\t Longitude: ${newyork.longitude}\n Latitude: ${paris.latitude}\t Longitude: ${paris.longitude}"),
                  Text("Distance: ${(distance/1000).round()} km"),
              
            ],
          )),
    );
  }
}
