import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:msp_app/fields/auton.dart';
import 'package:msp_app/fields/it.dart';
import 'package:msp_app/fields/media.dart';
import 'package:msp_app/fields/mobile.dart';
import 'package:msp_app/fields/web.dart';
import 'package:msp_app/ui/colors.dart';

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> with SingleTickerProviderStateMixin {



  @override
  Widget build(BuildContext context) {
    return new DefaultTabController (length: 5,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(backgroundColor: Color(0xFFC5CAE9),
          
            bottom: new TabBar(
              isScrollable: true,
              indicatorColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              labelColor: blue,
              tabs: <Widget>[
                new Tab(
                  icon: new Icon(Icons.phone_android),
                  text: "Mobile",
                ),
                new Tab(
                  icon: new Icon(Icons.laptop_mac),
                  text: "Web",
                ),
                new Tab(
                  icon: new Icon(MdiIcons.videoImage),
                  text: "Media",
                ),
                new Tab(
                  icon: new Icon(MdiIcons.serverNetwork),
                  text: "IT",
                ),
                new Tab(
                  icon: new Icon(MdiIcons.naturePeople),
                  text: "Autonomous",
                ),
            
              ],
            ),
            // title: Center(child: Text('Our Fields' , style: TextStyle(color:Colors.deepPurple , fontStyle: FontStyle.italic ),)  ) ,
          ),
        ),
        body: new TabBarView(
          children: [
            mobile(),
            web(),
            media(),
            it(),
            auton(),
          ]
        ),
      ));
  }
}
