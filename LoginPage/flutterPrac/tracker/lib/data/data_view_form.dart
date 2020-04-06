import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LineDataForm extends StatelessWidget {
  LineDataForm(this.dataSnapshot);
  final DocumentSnapshot dataSnapshot;

  @override
  Widget build(BuildContext context) {
    return lineListForm(context);
  }

  deleteData(docId) {
    Firestore.instance
        .collection('line_data_folder')
        .document(docId)
        .delete()
        .catchError((e) {
      print(e + '가 발생했네요. deteData를 확인해주세요.');
    });
  }

  getData(docId) {
    Firestore.instance.collection('line_data_folder').document(docId);
  }

  Widget lineListForm(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0)),
        child: ListTile(
          title: Text(dataSnapshot.data['num']),
          subtitle: Row(
            children: <Widget>[
              Text(dataSnapshot.data['id']),
              SizedBox(
                width: 10,
                height: 10,
              ),
              Text(dataSnapshot.data['line']),
            ],
          ),
          onLongPress: () {
            showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('삭제하시겠습니까?'),
                    content: Text(dataSnapshot.documentID.toString()),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(
                          '네',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.pop(context, '삭제되었습니다.');
                          deleteData(dataSnapshot.documentID);
                        },
                      ),
                      FlatButton(
                        child: Text(
                          '아니오',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.pop(context, '취소하였습니다..');
                        },
                      )
                    ],
                  );
                });
          },
        ),
      ),
    );
  }

  Widget cardForm(BuildContext context) {
    return Padding();
  }
}
