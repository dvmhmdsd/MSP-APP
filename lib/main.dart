import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:msp_app/ui/colors.dart';

import 'tabs/about.dart';
import 'tabs/events.dart';
import 'tabs/gallery.dart';
import 'tabs/sessions.dart';

const String appTitle = "MSP";

void main() {
//  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//    statusBarColor: primaryColor, //top bar color
//    statusBarIconBrightness: Brightness.light, //top bar icons
//  ));
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Home(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: purple),
        backgroundColor: white,
      ),
    ),
  );
}

class Home extends StatefulWidget {

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            appTitle,
            style: TextStyle(color: white),
          ),
          bottom: TabBar(tabs: [
            Tab(
              child: AutoSizeText("Events", maxLines: 1,),
            ),
            Tab(
              child: AutoSizeText("Sessions", maxLines: 1,),
            ),
            Tab(
              child: AutoSizeText("Portfolio", maxLines: 1,),
            ),
            Tab(
              child: AutoSizeText("About", maxLines: 1,),
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            Events(),
            Sessions(),
            Gallery(),
            About(),
          ],
        ),
      ),
    );
  }
}
