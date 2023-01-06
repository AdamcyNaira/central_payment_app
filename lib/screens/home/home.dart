import 'package:flutter/material.dart';

import '../../util/constants.dart';
import '../../widgets/home_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: 15),
          height: screenHeight(context),
          width: screenWidth(context),
          decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.5],
            colors: [
              Color(0XFFffffff),
              Color.fromARGB(255, 185, 194, 206),
            ],
          ),
        ),
          child: Column(
            children: [
              Body(),
              TopBar(),
            ],
          ),
        ),
      ),
    );
  }
}
