import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/login/login_layout.dart';
import 'package:tracker/map/track_map_layout.dart';
import 'login/check_login.dart';

void main() => runApp(EccentricApp());

class EccentricApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EccentricPath',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Login(),
    );
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return ChangeNotifierProvider<CheckLogin>.value(
                value: CheckLogin(), child: AuthPage());
          } else {
            return MyHomePage(email: snapshot.data.email, title: "지도화면");
          }
        });
  }
}

//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  StreamSubscription _locationSubscription;
//  Location _locationTracker = Location();
//  Marker marker;
//  Polyline polyline;
//  Circle circle;
//  GoogleMapController _controller;
//  List<LatLng> lineList = [];
//  List<LatLng> line = [];
//
//  //홈화면 디자인 및 구성
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
//      body: GoogleMap(
//        mapType: MapType.normal,
//        initialCameraPosition: initialLocation,
//        markers: Set.of((marker != null) ? [marker] : []),
//        circles: Set.of((circle != null) ? [circle] : []),
//        polylines: Set.of((polyline != null) ? [polyline] : []),
//        onMapCreated: (GoogleMapController controller) {
//          _controller = controller;
//        },
//      ),
//      floatingActionButton: FloatingActionButton(
//          child: Icon(Icons.location_searching),
//          onPressed: () {
//            getCurrentLocation();
//          }),
//      bottomNavigationBar: BottomAppBar(
//        color: Colors.white,
//        child: Container(
//          height: 80.0,
//        ),
//      ),
//      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//    );
//  }
//
//  //마커랑 주변 이미지 옵션들
//  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
//    LatLng mylatlng = LatLng(newLocalData.latitude, newLocalData.longitude);
//
//    this.setState(() {
//      marker = Marker(
//          markerId: MarkerId('me'),
//          position: mylatlng,
//          rotation: newLocalData.heading,
//          draggable: false,
//          zIndex: 2,
//          flat: true,
//          anchor: Offset(0.5, 0.5),
//          icon: BitmapDescriptor.fromBytes(imageData));
//      circle = Circle(
//          circleId: CircleId("car"),
//          radius: newLocalData.accuracy,
//          zIndex: 1,
//          strokeColor: Colors.blue,
//          center: mylatlng,
//          fillColor: Colors.blue.withAlpha(20));
//    });
//  }
//
//  // 폴리라인을 그리는 메서드
//  void updatePolyline(LocationData data) {
//    if (line != null) {
//      line.clear();
//    }
//    //시작점
//    LatLng starting = LatLng(data.latitude, data.longitude);
//
//    //시작점을 추가한다.
//    print("이게 시작점 ? " + starting.toString());
//    lineList.add(starting);
//
////    print("<>>LINE>>>>?" + line.toString());
//
//    if (lineList.length >= 2) {
//      for (int i = 0; i < lineList.length - 1; i++) {
//        if (lineList[i] == lineList[i + 1]) {
//          lineList.removeAt(i);
//          print("삭제함>>>" + lineList.toString());
//        } else {
//          line.add(lineList[i]);
//          line.add(lineList[i + 1]);
//        }
//        if (line.length == 2 && line[0] != line[1]) {
//          print("들어오긴했다." + line.toString());
//
//          this.setState(() {
//            polyline = Polyline(
//              polylineId: PolylineId("road"),
//              points: line,
//              color: Colors.deepPurpleAccent,
//              width: 10,
//            );
//          });
//        }
//      }
//    }
//
//    print("이건 테스트야. LINE__CLEAR??" + line.toString());
//    print("이건 테스트야. 라인들비교" + lineList.toString());
//  }
//
//  //최초위치? 및 카메라 위치
//  static final CameraPosition initialLocation = CameraPosition(
//    target: LatLng(37.656082000, 127.117828000),
//    zoom: 10.0,
//  );
//
//  //내 마커 모양 가져오는 메서드
//  Future<Uint8List> getMarker() async {
//    ByteData byteData =
//        await DefaultAssetBundle.of(context).load("assets/marker.png");
//    return byteData.buffer.asUint8List();
//  }
//
//  //위치 표현 과 이미지 옵션들을 연결해준다.
//  void getCurrentLocation() async {
//    try {
//      Uint8List imageData = await getMarker();
//      //getLocation()으로 위치 가져온다.
//      var location = await _locationTracker.getLocation();
//
//      // 그 위치 정보를 드래로 그려준다.
//      updateMarkerAndCircle(location, imageData);
//      updatePolyline(location);
//
//      if (_locationSubscription != null) {
//        _locationSubscription.cancel();
//      }
///*-------------------------------------------------------*/
//
//      // 위치정보가 변경되었다면, 위치를 가져오면서, 카메라 위치도 바꾸면서, 그림도 그대로 따라 그려준다.
//      _locationSubscription =
//          _locationTracker.onLocationChanged().listen((newLocalData) {
//        // if (_controller != null) {
//        _controller.animateCamera(CameraUpdate.newCameraPosition(
//            new CameraPosition(
//                target: LatLng(newLocalData.latitude, newLocalData.longitude),
//                tilt: 0,
//                zoom: 15.0,
//                bearing: 0)));
//
//        /*폴리라인 추가하는 부분인데. 확인 필요*/
//        updateMarkerAndCircle(newLocalData, imageData);
//        updatePolyline(newLocalData);
//      });
//    } on PlatformException catch (e) {
//      if (e.code == "PERMISSION DENIED") {
//        debugPrint("PERMISSION DENIED CHECK PLEASE");
//      }
//    }
//  }
//
//  @override
//  void dispose() {
//    if (_locationSubscription != null) {
//      _locationSubscription.cancel();
//    }
//    super.dispose();
//  }
//}
