import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var myMarkes = HashSet<Marker>();
  late BitmapDescriptor customMarker;
  List<Polyline> myPolyline = [];

  getCustomMarker() async {
    customMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, 'assets/images/c2s.png');
  }

  @override
  void initState() {
    super.initState();
    getCustomMarker();
    createPloyline();
  }

  createPloyline() {
    myPolyline.add(
      Polyline(
          polylineId: PolylineId('1'),
          color: Colors.blue,
          width: 3,
          points: const [
            LatLng(36.593208, 36.159194),
            LatLng(36.593208, 36.159194),
          ],
          patterns: [
            PatternItem.dash(20),
            PatternItem.gap(10),
          ]),
    );
  }

  Set<Polygon> myPolygon() {
    var polygonCoords = <LatLng>[];
    polygonCoords.add(const LatLng(37.43296265331129, -122.08832357078792));
    polygonCoords.add(const LatLng(37.43006265331129, -122.08832357078792));
    polygonCoords.add(const LatLng(37.43006265331129, -122.08332357078792));
    polygonCoords.add(const LatLng(37.43296265331129, -122.08832357078792));

    var polygonSet = Set<Polygon>();
    polygonSet.add(Polygon(
        polygonId: const PolygonId('1'),
        points: polygonCoords,
        strokeWidth: 1,
        strokeColor: Colors.red));

    return polygonSet;
  }

  Set<Circle> myCircles = Set.from([
    Circle(
      circleId: CircleId('1'),
      center: LatLng(36.593208, 36.159194),
      radius: 10000,
      strokeWidth: 1,
    )
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("First Google Maps"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.terrain,
            initialCameraPosition: const CameraPosition(
              target: LatLng(36.593208, 36.159194),
              zoom: 12,
            ),
            onMapCreated: (GoogleMapController googleMapController) {
              setState(() {
                myMarkes.add(
                  Marker(
                    markerId: const MarkerId('1'),
                    position: const LatLng(36.593208, 36.159194),
                    infoWindow: const InfoWindow(
                      title: 'TİTLE',
                      snippet: 'Description',
                    ),
                    onTap: () {
                      print("Marker tabed");
                    },
                    // icon:customMarker
                  ),
                );
              });
            },
            markers: myMarkes,
            polygons: myPolygon(),
            /*circles: myCircles,
            polylines: myPolyline.toSet(),*/
          ),
          Container(
              //  child: Image.asset('assets/images/c2s.png'),
              // alignment: Alignment.topCenter,
              ),
          Container(
            child: Text(
              "Welcome Maps",
              style: TextStyle(fontSize: 35),
            ),
            alignment: Alignment.bottomCenter,
          ),
        ],
      ),
    );
  }
}
