import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tracker/data/data_view_form.dart';

class LineDataSheet extends StatefulWidget {
  @override
  _LineDataSheetState createState() => _LineDataSheetState();
}

class _LineDataSheetState extends State<LineDataSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("내가 저장한 경로"),
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('line_data_folder').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            List<DocumentSnapshot> documents = snapshot.data.documents;
            return ListView(
              padding: EdgeInsets.only(top: 20.0),
              children: documents
                  .map((eachDocument) => LineDataForm(eachDocument))
                  .toList(),
            );
          }),
    );
  }
}
