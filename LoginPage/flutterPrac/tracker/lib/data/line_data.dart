import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LineDataShow extends StatelessWidget {
  LineDataShow({this.lineList, this.line, this.email});
  final List<LatLng> lineList;
  final List<LatLng> line;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('저장된 경로'),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
