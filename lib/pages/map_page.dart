import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<Polygon> _polygons = [];
  List<LatLng> _csvPoints = [];

  @override
  void initState() {
    super.initState();
    _loadCsvData().then((_) {
      _loadGeoJson();
    });
  }

  Future<void> _loadGeoJson() async {
    final String response =
        await rootBundle.loadString('assets/gadm41_KOR_2.json');
    final data = json.decode(response);
    List<Polygon> polygons = [];

    for (var feature in data['features']) {
      List<List<LatLng>> allPolygons = [];

      if (feature['geometry']['type'] == 'Polygon') {
        List<LatLng> points = [];
        for (var coord in feature['geometry']['coordinates'][0]) {
          points.add(LatLng(coord[1], coord[0]));
        }
        allPolygons.add(points);
      } else if (feature['geometry']['type'] == 'MultiPolygon') {
        for (var polygon in feature['geometry']['coordinates']) {
          List<LatLng> points = [];
          for (var coord in polygon[0]) {
            points.add(LatLng(coord[1], coord[0]));
          }
          allPolygons.add(points);
        }
      }

      for (var points in allPolygons) {
        polygons.add(Polygon(
          points: points,
          color: _polygonContainsCsvPoint(points)
              ? Colors.red.withOpacity(0.5)
              : Colors.blue.withOpacity(0.3),
          borderStrokeWidth: 2,
          borderColor: Colors.blue,
          isFilled: true,
        ));
      }
    }

    setState(() {
      _polygons = polygons;
    });
  }

  Future<void> _loadCsvData() async {
    final String csvString = await rootBundle.loadString('assets/level2.csv');
    List<List<dynamic>> csvTable = CsvToListConverter().convert(csvString);

    List<LatLng> csvPoints = [];

    for (var row in csvTable) {
      if (row[0] != 'Latitude') {
        // Assuming first row is header
        final latitude = double.tryParse(row[5].toString());
        final longitude = double.tryParse(row[6].toString());

        if (latitude != null && longitude != null) {
          LatLng point = LatLng(latitude, longitude);
          csvPoints.add(point);
        }
      }
    }

    setState(() {
      _csvPoints = csvPoints;
    });
  }

  bool _polygonContainsCsvPoint(List<LatLng> polygonPoints) {
    for (var point in _csvPoints) {
      if (_pointInPolygon(point, polygonPoints)) {
        return true;
      }
    }
    return false;
  }

  bool _pointInPolygon(LatLng point, List<LatLng> polygonPoints) {
    int intersectCount = 0;
    for (int j = 0; j < polygonPoints.length - 1; j++) {
      if ((polygonPoints[j].latitude > point.latitude) !=
              (polygonPoints[j + 1].latitude > point.latitude) &&
          point.longitude <
              (polygonPoints[j + 1].longitude - polygonPoints[j].longitude) *
                      (point.latitude - polygonPoints[j].latitude) /
                      (polygonPoints[j + 1].latitude -
                          polygonPoints[j].latitude) +
                  polygonPoints[j].longitude) {
        intersectCount++;
      }
    }
    return (intersectCount % 2) == 1;
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
