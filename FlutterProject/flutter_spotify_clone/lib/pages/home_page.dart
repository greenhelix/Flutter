import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spotify_clone/json/songs_json.dart';
import 'package:flutter_spotify_clone/theme/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeMenu1 = 0;
  int activeMenu2 = 2;

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
      elevation: 1,
      title: Padding(
        padding: const EdgeInsets.only(left: 10, right: 0),
        child: Row(
          // children 에 들어있는 것끼리의 간격 배치를 설정해줄 수 있다.
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Explore",
              style: TextStyle(
                  fontSize: 20, color: white, fontWeight: FontWeight.bold),
            ),
            Icon(Entypo.list),
          ],
        ),
      ),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 음악 카테고리 부분
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, top: 0),
                  child: Row(
                      // list 의 값 인덱스대로 뿌려준다.
                      children: List.generate(songType_1.length, (index) {
                    return Padding(
                      // 음악 카테고리 사이의 간격
                      padding: const EdgeInsets.only(right: 25),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            activeMenu1 = index;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              songType_1[index],
                              style: TextStyle(
                                  fontSize: 15,
                                  color: activeMenu1 == index ? primary : grey,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            // 하단 밑줄 표기 되게 하기
                            activeMenu1 == index
                                ? Container(
                                    width: 25,
                                    height: 3,
                                    decoration: BoxDecoration(
                                        color: primary,
                                        borderRadius: BorderRadius.circular(5)),
                                  )
                                : Container()
                          ],
                        ),
                      ),
                    );
                  })),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // 앨범사진 부분
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: List.generate(songs.length - 5, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              Container(
                                width: 180,
                                height: 180,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(songs[index]['img']),
                                        fit: BoxFit.cover),
                                    color: primary,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                songs[index]['title'],
                                style: TextStyle(
                                    fontSize: 15,
                                    color: white,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: 180,
                                child: Text(
                                  songs[index]['description'],
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: grey,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, top: 10),
                  child: Row(
                      // list 의 값 인덱스대로 뿌려준다.
                      children: List.generate(songType_2.length, (index) {
                    return Padding(
                      // 음악 카테고리 사이의 간격
                      padding: const EdgeInsets.only(right: 25),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            activeMenu2 = index;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              songType_2[index],
                              style: TextStyle(
                                  fontSize: 15,
                                  color: activeMenu2 == index ? primary : grey,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            // 하단 밑줄 표기 되게 하기
                            activeMenu2 == index
                                ? Container(
                                    width: 25,
                                    height: 3,
                                    decoration: BoxDecoration(
                                        color: primary,
                                        borderRadius: BorderRadius.circular(5)),
                                  )
                                : Container()
                          ],
                        ),
                      ),
                    );
                  })),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: List.generate(songs.length - 5, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              Container(
                                width: 180,
                                height: 180,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage(songs[index + 5]['img']),
                                        fit: BoxFit.cover),
                                    color: primary,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                songs[index + 5]['title'],
                                style: TextStyle(
                                    fontSize: 15,
                                    color: white,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: 180,
                                child: Text(
                                  songs[index + 5]['description'],
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: grey,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
