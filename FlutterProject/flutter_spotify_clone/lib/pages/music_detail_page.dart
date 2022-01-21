import 'package:flutter/cupertino.dart';
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
  // 플레이어
  bool isPlaying = true;

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
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              width: size.width - 80,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    AntDesign.addfolder,
                    color: white,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 18,
                            color: white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(
                          widget.description,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15, color: white.withOpacity(0.5)),
                        ),
                      )
                    ],
                  ),
                  Icon(
                    Feather.more_vertical,
                    color: white,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "1:50",
                  style: TextStyle(color: white.withOpacity(0.5)),
                ),
                Text(
                  "4:68",
                  style: TextStyle(color: white.withOpacity(0.5)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: null,
                    icon: Icon(
                      Feather.shuffle,
                      color: white.withOpacity(0.8),
                      size: 25,
                    )),
                IconButton(
                    onPressed: null,
                    icon: Icon(
                      Feather.skip_back,
                      color: white.withOpacity(0.8),
                      size: 25,
                    )),
                IconButton(
                  onPressed: () {
                    if (isPlaying) {}
                  },
                  iconSize: 50,
                  icon: Container(
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: primary),
                    child: Center(
                      child: Icon(
                        isPlaying
                            ? Entypo.controller_stop
                            : Entypo.controller_play,
                        size: 28,
                        color: white,
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: null,
                    icon: Icon(
                      Feather.skip_forward,
                      color: white.withOpacity(0.8),
                      size: 25,
                    )),
                IconButton(
                    onPressed: null,
                    icon: Icon(
                      AntDesign.retweet,
                      color: white.withOpacity(0.8),
                      size: 25,
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Feather.tv, color: primary, size: 20),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: EdgeInsets.only(top: 3),
                child: Text(
                  "Chromecast is ready",
                  style: TextStyle(color: primary),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
