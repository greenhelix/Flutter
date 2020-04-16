import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class DataDetailLayout extends StatefulWidget {
  @override
  _DataDetailLayoutState createState() => _DataDetailLayoutState();
}

class _DataDetailLayoutState extends State<DataDetailLayout> {
  File _image;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('세부설정 화면'),
        backgroundColor: Colors.transparent,
        actions: <Widget>[_detailControlPopup()],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //상세내용 입력부분
            Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: screenSize.width * 0.09,
                      right: screenSize.width * 0.09,
                      top: screenSize.height * 0.1,
                      bottom: screenSize.height * 0.01),
                  child: Card(
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 12, right: 12, bottom: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              height: screenSize.height * 0.01,
                            ),
                            TextField(
                              decoration: InputDecoration(labelText: '경로이름'),
                            ),
                            TextField(
                                decoration: InputDecoration(labelText: '날짜'),
                                onTap: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(2018, 3, 5),
                                      maxTime: DateTime(2019, 6, 7),
                                      onChanged: (date) {
                                    print('change $date');
                                  }, onConfirm: (date) {
                                    print('confirm $date');
                                  },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.ko);
                                }),
                            //공간( 경로/날짜 --- 거리/수단 )
                            Container(
                              height: screenSize.height * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('거리'),
                                Text('수단'),
                              ],
                            ),
                          ],
                        ),
                      )),
                ),
                Positioned(
                    left: screenSize.width * 0.35,
                    right: screenSize.width * 0.35,
                    top: 0,
                    child: GestureDetector(
                        onTap: () {
                          getImage(ImageSource.gallery);
                        },
                        child: _firstRouteImage(screenSize, _image))),
              ],
            ),
            //경로 지도
            SizedBox(
              width: screenSize.width * 0.9,
              height: screenSize.height * 0.3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(37.65788522718552, 127.12529190283237),
                      zoom: 10.0),
                  mapType: MapType.normal,
                ),
              ),
            ),
//            SizedBox(
//              height: 10,
//            ),
            // 경로사진 추가 버튼
            RaisedButton(child: Text('상세 사진 추가'), onPressed: () {}),
          ],
        ),
      ),
    );
  }

  void getImage(ImageSource source) async {
    print('이미지를 갤러리에서 가져옵니다.');
    var image = await ImagePicker.pickImage(source: source);
    setState(() {
      _image = image;
    });
  }
}

//상단 팝업 메뉴 리스트
Widget _detailControlPopup() => PopupMenuButton<int>(
    itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text(
              '저장',
              style: TextStyle(color: Colors.black),
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: Text(
              '공유하기',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          PopupMenuItem(
            value: 3,
            child: Text(
              '삭제',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ]);
//메인 첫 사진 추가 공간
Widget _firstRouteImage(Size size, File check) {
  return Container(
    margin: const EdgeInsets.all(10),
    width: 100,
    height: 100,
    child: (check != null)
        ? FittedBox(
            fit: BoxFit.fitWidth,
            child: Image.file(check),
          )
        : FittedBox(
            fit: BoxFit.contain,
            child: new Icon(Icons.add_photo_alternate),
          ),
  );
}
