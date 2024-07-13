import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<Polygon> _polygons = [];

  @override
  void initState() {
    super.initState();
    _loadGeoJson();
  }

  Future<void> _loadGeoJson() async {
    final String response =
        await rootBundle.loadString('assets/gadm41_KOR_2.json');
    final data = json.decode(response);
    List<Polygon> polygons = [];

    for (var feature in data['features']) {
      List<LatLng> points = [];
      for (var coord in feature['geometry']['coordinates'][0][0]) {
        points.add(LatLng(coord[1], coord[0]));
      }
      polygons.add(Polygon(
        points: points,
        color: Colors.blue.withOpacity(0.3),
        borderStrokeWidth: 2,
        borderColor: Colors.blue,
      ));
    }

    setState(() {
      _polygons = polygons;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('지도 페이지'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(36.5, 127.5),
          zoom: 7.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          PolygonLayer(
            polygons: _polygons,
          ),
        ],
      ),
    );
  }
}
