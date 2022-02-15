import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spotify_clone/theme/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: getAppBar(),
    );
  }

  PreferredSizeWidget getAppBar() {
    return AppBar(
      backgroundColor: black,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            "Explore",
            style: TextStyle(
                fontSize: 20, color: white, fontWeight: FontWeight.bold),
          ),
          Icon(Entypo.list)
        ],
      ),
    );
  }
}
