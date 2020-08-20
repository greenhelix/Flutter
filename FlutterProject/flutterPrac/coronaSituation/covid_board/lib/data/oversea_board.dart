import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class JSONGet extends StatefulWidget {
  @override
  _JSONGetState createState() => _JSONGetState();
}

class _JSONGetState extends State<JSONGet> {
  Future<String> getData() async {
    http.Response response = await http.get(Uri.encodeFull(
        'http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson?serviceKey=0XPqoJ92f%2BHITCSMY9zKbbfucy007IN5LgUDC2rMQJ1D09M0kFru1jIeHxNygEHXo4QnPlEgdgjrMmTpGzhOkA%3D%3D'));
    print(response.body);
    List data = jsonDecode(response.body);
    print("***");
    print(data[1]['title']);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: new Center(
        child: new RaisedButton(child: new Text("GET"), onPressed: getData),
      ),
    );
  }
}

//http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson?serviceKey=인증키(URL Encode)&pageNo=1&numOfRows=10&startCreateDt=20200310&endCreateDt=20200315
