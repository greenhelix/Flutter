import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tracker/map/track_map_layout.dart';

class FloatingController extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  final IconData icon;
  FloatingController({this.onPressed, this.tooltip, this.icon});

  @override
  _FloatingControllerState createState() => _FloatingControllerState();
}

class _FloatingControllerState extends State<FloatingController>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });

    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _buttonColor = ColorTween(begin: Colors.deepPurple, end: Colors.transparent)
        .animate(CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.00, 1.00, curve: Curves.linear)));

    _translateButton = Tween<double>(begin: _fabHeight, end: -14.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 0.75, curve: _curve)));

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  /*여기서부터는 내가 원하는 플로팅 메뉴아이템들 리스트이다.*/
  Widget menuToggle() {
    return Container(
      child: FloatingActionButton(
        heroTag: "menu",
        onPressed: animate,
        tooltip: 'MenuToggle',
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
        onPressed: () {},
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
        onPressed: null,
        tooltip: 'TrackStart',
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(Icons.directions_walk),
      ),
    );
  }

  Widget trackSave() {
    return Container(
      child: FloatingActionButton(
        heroTag: "save",
        onPressed: null,
        tooltip: 'TrackSave',
        backgroundColor: Colors.orangeAccent,
        child: Icon(
          Icons.save,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
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
            child: trackStart(),
          ),
          Transform(
            transform:
                Matrix4.translationValues(0.0, _translateButton.value, 0.0),
            child: myPos(),
          ),
          menuToggle(),
        ],
      ),
    );
  }
}

//class CircularButton extends StatelessWidget {
//  final double width;
//  final double height;
//  final Color color;
//  final Icon icon;
//  final Function onClick;
//
//  CircularButton(
//      {this.color, this.width, this.height, this.icon, this.onClick});
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//      width: width,
//      height: height,
//      child: IconButton(icon: null, enableFeedback: true, onPressed: onClick),
//    );
//  }
//}
