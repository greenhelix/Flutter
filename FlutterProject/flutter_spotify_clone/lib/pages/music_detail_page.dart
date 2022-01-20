import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spotify_clone/theme/colors.dart';

class MusicDetailPage extends StatefulWidget {
  final String title;
  final String description;
  final Color color;
  final String img;
  final String songUrl;

  const MusicDetailPage(
      {Key? key,
      required this.title,
      required this.description,
      required this.color,
      required this.img,
      required this.songUrl})
      : super(key: key);

  @override
  _MusicDetailPageState createState() => _MusicDetailPageState();
}

class _MusicDetailPageState extends State<MusicDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  PreferredSizeWidget getAppBar() {
    return AppBar(
      backgroundColor: black,
      elevation: 0,
      actions: const [
        IconButton(
          onPressed: null,
          icon: Icon(Feather.more_vertical),
          color: white,
        )
      ],
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              // 효과를 위에 놔주고 그 다음으로 사진을 놓아서 효과가 드러나게 한다.
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                child: Container(
                  width: size.width - 100,
                  height: size.width - 100,
                  decoration: BoxDecoration(
                    // 앨범 사진 그림자 효과주기
                    boxShadow: [
                      BoxShadow(
                          color: widget.color,
                          blurRadius: 50,
                          spreadRadius: 5,
                          offset: Offset(-10, 40))
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                child: Container(
                  width: size.width - 60,
                  height: size.width - 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(widget.img), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
