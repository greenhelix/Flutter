import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:tracker/data/line_data.dart';
import 'package:tracker/draw_menu/drawer_layout.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.email}) : super(key: key);
  final String title;
  final String email;

  @override
  _MyHomePageState createState() => _MyHomePageState(this.email);
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  _MyHomePageState(this.email);
  Firestore firestore = Firestore.instance;
  String email;
  StreamSubscription _locationSubscription;
  Location _myLocation = Location();
  Marker marker;
  Polyline polyline;
  Circle circle;
  GoogleMapController _controller;
  List<LatLng> lineList = [];
  List<LatLng> line = [];
  bool menuOpen = false;
  bool sTrack = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOutCirc;
  double _fabHeight = 56.0;
  int index = 0;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.3;
    return degree / unitRadian;
  }

  final mapScaffoldKey = GlobalKey<ScaffoldState>();
  //홈화면 디자인 및 구성
  @override
  Widget build(BuildContext context) {
    Size drawer = MediaQuery.of(context).size;
    return Scaffold(
      key: mapScaffoldKey,
      endDrawer: DrawerLayout(email),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialLocation,
        markers: Set.of((marker != null) ? [marker] : []),
        circles: Set.of((circle != null) ? [circle] : []),
        polylines: Set.of((polyline != null) ? [polyline] : []),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Transform(
            transform: Matrix4.translationValues(
                0.0, _translateButton.value * 3.0, 0.0),
            child: trackSave(),
          ),
          Transform(
              transform: Matrix4.translationValues(
                  0.0, _translateButton.value * 2.0, 0.0),
              child: trackStart()),
          Transform(
            transform:
                Matrix4.translationValues(0.0, _translateButton.value, 0.0),
            child: myPos(),
          ),
          menuToggle(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

//  transform: Matrix4.translationValues(
//  0.0, _translateButton.value * 2.0, 0.0),

  //마커랑 주변 이미지 옵션들
  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng myLatLng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId('me'),
          position: myLatLng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: CircleId("car"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: myLatLng,
          fillColor: Colors.blue.withAlpha(20));
    });
  }

  // 폴리라인을 그리는 메서드
  void updatePolyline(LocationData data) {
    if (line != null) {
      line.clear();
    }
    //시작점
    LatLng starting = LatLng(data.latitude, data.longitude);

    //시작점을 추가한다.
    //print("이게 시작점 ? " + starting.toString());
    lineList.add(starting);

    if (lineList.length >= 2) {
      for (int i = 0; i < lineList.length - 1; i++) {
        if (lineList[i] == lineList[i + 1]) {
          lineList.removeAt(i);
          print("삭제함>>>" + lineList.toString());
        } else {
          line.add(lineList[i]);
          line.add(lineList[i + 1]);
        }
        if (line.length == 2 && line[0] != line[1]) {
          print("들어오긴했다." + line.toString());

          this.setState(() {
            polyline = Polyline(
              polylineId: PolylineId("road"),
              points: line,
              color: Colors.black,
              width: 5,
            );
          });
        }
      }
    }

    print("이건 테스트야. LINE__CLEAR??" + line.toString());
    print("이건 테스트야. 라인들비교" + lineList.toString());
  }

  //최초위치? 및 카메라 위치
  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(37.656082000, 127.117828000),
    zoom: 10.0,
  );

  //내 마커 모양 가져오는 메서드
  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/marker.png");
    return byteData.buffer.asUint8List();
  }

  //위치 표현 과 이미지 옵션들을 연결해준다.
  void getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker();
      //getLocation()으로 위치 가져온다.
      var location = await _myLocation.getLocation();

      _controller.animateCamera(CameraUpdate.newCameraPosition(
          new CameraPosition(
              target: LatLng(location.latitude, location.longitude),
              zoom: 15.0)));
      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }
      /*-------------------------------------------------------*/

    } on PlatformException catch (e) {
      if (e.code == "PERMISSION DENIED") {
        debugPrint("PERMISSION DENIED CHECK PLEASE");
      }
    }
  }

  void startTracker() async {
    try {
      Uint8List imageData = await getMarker();
      var location = await _myLocation.getLocation();
      updatePolyline(location);
      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _myLocation.onLocationChanged().listen((newLocalData) {
        _controller.animateCamera(CameraUpdate.newCameraPosition(
            new CameraPosition(
                target: LatLng(newLocalData.latitude, newLocalData.longitude),
                tilt: 0,
                zoom: 15.0,
                bearing: 0)));
        updateMarkerAndCircle(newLocalData, imageData);
        updatePolyline(newLocalData);
      });
    } on PlatformException catch (e) {
      if (e.code == "PERMISSION DENIED") {
        debugPrint("트랙커 시작부분이 이상합니다. startTracker() error");
      }
    }
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    if (_animationController != null) {
      _animationController.dispose();
    }

    super.dispose();
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100))
          ..addListener(() {
            setState(() {});
          });

    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _buttonColor = ColorTween(begin: Colors.deepPurple, end: Colors.transparent)
        .animate(CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.00, 1.00, curve: Curves.easeOutCirc)));

    _translateButton = Tween<double>(begin: _fabHeight, end: -13.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 0.75, curve: _curve)));

    super.initState();
  }

  menuAnimate() {
    if (menuOpen == false) {
      print("menu open");
      _animationController.forward();
    } else {
      print("menu close");
      _animationController.reverse();
    }
    menuOpen = !menuOpen;
  }

  /*여기서부터는 내가 원하는 플로팅 메뉴아이템들 리스트이다.*/
  Widget menuToggle() {
    return Container(
      child: FloatingActionButton(
        heroTag: "menu",
        tooltip: 'MenuToggle',
        onPressed: menuAnimate,
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  Widget myPos() {
    return Container(
      child: FloatingActionButton(
        heroTag: "pos",
        onPressed: () {
          getCurrentLocation();
          _animationController.reverse();
        },
        tooltip: 'MyLocation',
        backgroundColor: Colors.yellowAccent,
        child: Icon(Icons.my_location),
      ),
    );
  }

  Widget trackStart() {
    return Container(
      child: FloatingActionButton(
        heroTag: "start",
        onPressed: () {
          if (sTrack) {
            startTracker();
          } else {
            line.clear();
            lineList.clear();
            getCurrentLocation();
          }
          sTrack = !sTrack;
        },
        tooltip: 'TrackStart',
        backgroundColor: Colors.lightBlueAccent,
        child: sTrack ? Icon(Icons.play_arrow) : Icon(Icons.pause),
      ),
    );
  }

  Widget trackSave() {
    return Container(
      child: FloatingActionButton(
        heroTag: "save",
        onPressed: () {
          showAlert(context);
        },
        tooltip: 'TrackSave',
        backgroundColor: Colors.orangeAccent,
        child: Icon(
          Icons.save,
        ),
      ),
    );
  }

  final TextEditingController _dataIndexController = TextEditingController();
  void showAlert(BuildContext context) async {
    String result = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("저장하시겠습니까?"),
            content: TextFormField(
              controller: _dataIndexController,
              decoration: InputDecoration(labelText: '몇번째 경로입니까?'),
              validator: (String s) {
                if (s.isEmpty) {
                  return "입력해주셔야합니다.";
                }
                return null;
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('네', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.pop(context, '저장되었습니다.');
                  firestore
                      .collection('line_data_folder')
                      .document(_dataIndexController.text + '번 경로')
                      .setData({
                    'num': _dataIndexController.text,
                    'id': email,
                    'line': lineList.toString()
                  });
                },
              ),
              FlatButton(
                  child: Text('아니요', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    Navigator.pop(context, "취소하셨습니다.");
                  }),
            ],
          );
        });

    mapScaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(
          '$result',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.yellowAccent,
        action: SnackBarAction(
          label: "완료",
          onPressed: () {},
          textColor: Colors.black,
        ),
      ));
  }
}
