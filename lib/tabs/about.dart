import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}


class _AboutState extends State<About> {
  List data;
  List userData;
  
  
  Future getData() async {
    http.Response response = await http.get(
      "https://my-json-server.typicode.com/salah-rashad/msp-json/sessions");
    data = json.decode(response.body);
    setState(() {
      userData = data;
    });
  }
  
  @override
  void initState() {
    super.initState();
    getData();
  }
  
  final List<String> images = [
    'images/developers.png',
    'images/marketing.png',
    'images/hr.jpg',
    'images/geeks.png',
    'images/loc.png',
    'images/media.jpg',
    'images/pr.jpg',
    'images/supervisor.png'
  ];
  final List<String> title = [
    'Developers',
    'Marketing',
    'HR',
    'Geeks',
    'loc',
    'Media',
    'PR',
    'Supervisor'
  ];
  
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery
      .of(context)
      .size
      .width;
    final _height = MediaQuery
      .of(context)
      .size
      .height;
    
    
    return new Stack(
      children: <Widget>[
        new Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/sky.jpg'),
              fit: BoxFit.fill,
            
            ),
          ),
        ),
        new BackdropFilter(
          filter: new ui.ImageFilter.blur(
            sigmaX: 6.0,
            sigmaY: 6.0,
          ),
        ),
        
        
        new Scaffold(
          
          drawer: new Drawer(child: new Container(),),
          backgroundColor: Colors.transparent,
          
          body: new SingleChildScrollView(
            child: Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    height: _height / 2.5,
                    width: double.infinity,
                    child: Image.asset(
                      'images/msp1.jpg', fit: BoxFit.cover,)),
                  Container(
                    margin: EdgeInsets.fromLTRB(20.0, 200.0, 20.0, 20.0),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple[50],
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("MSP Tech Club at Al-Azhar", style: Theme
                          .of(context)
                          .textTheme
                          .title,),
                        SizedBox(height: 10.0),
                        Text("Founded on 1 February 2012"),
                        SizedBox(height: 10.0),
                        Divider(),
                        SizedBox(height: 10.0,),
                        Row(children: <Widget>[
                          Icon(Icons.info,
                            color: Colors.indigo,),
                          SizedBox(width: 5.0,),
                          Text("About Us"),
                        ],),
                        SizedBox(height: 10.0,),
                        Text(
                          "  MSP Tech Club at Al-Azhar is a student community program that promotes advanced technology through education, practice, and innovation. It also provides students with both technical and non-technical sessions needed which is packing their lives with high level of skills and supporting their careers with opportunities.",
                          textAlign: TextAlign.justify,),
                        SizedBox(height: 10.0,),
                        Row(children: <Widget>[
                          Icon(
                            Icons.center_focus_strong, color: Colors.indigo,),
                          SizedBox(width: 5.0,),
                          Text("Our Mission"),
                        
                        ],),
                        SizedBox(height: 10.0,),
                        Text(
                          " MSP Tech Club at Al-Azhar has a clear mission to help the students in the campus and to be there for any kind of support needed whether it’s technical or non-technical and to help them find their most suitable career.",
                          textAlign: TextAlign.justify,),
                        SizedBox(height: 10.0,),
                        Row(children: <Widget>[
                          Icon(MdiIcons.creation, color: Colors.indigo,),
                          SizedBox(width: 5.0,),
                          Text("Products "),
                        
                        ],),
                        SizedBox(height: 10.0,),
                        Text(
                          " Technical Sessions, Soft Skills, workshops, courses and competitions.",
                          textAlign: TextAlign.justify,),
                        SizedBox(height: 10.0,),
                        Row(children: <Widget>[
                          Icon(Icons.people, color: Colors.indigo,),
                          SizedBox(width: 5.0,),
                          Text("Our Community"),
                        
                        ],),
                        SizedBox(height: 10.0,),
                        Container(
                          height: 110.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: images.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                color: Colors.deepPurple[50],
                                child: Container(
                                  child: GestureDetector(
                                    onTap: () => {},
                                    // _onTapItem(context,index),
                                    child: Hero(tag: "item$index",
                                      child: _buildPlaceToVisit(
                                        image: images[index % images.length],
                                        title: '${title[index %
                                                        title.length]}',),
                                    
                                    ),),
                                ),
                              );
                            }),
                        ),
                        
                        new Divider(
                          height: _height / 30, color: Colors.blue,),
                        new Row(
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(right: 25.0,)),
                            InkWell(
                              child: new CircleAvatar(
                                backgroundColor: Colors.redAccent,
                                child: new Icon(
                                  MdiIcons.youtube, color: Colors.white,
                                  size: 25.0,
                                ),
                                radius: 20.0,
                              ),
                              onTap: () async {
                                const url = 'https://www.youtube.com/channel/UCnrCvhZJDpijR61BNo0rk9Q';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                            ),
                            Padding(padding: EdgeInsets.only(right: 30.0)),
                            InkWell(
                              child: new CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: new Icon(
                                  MdiIcons.facebook, color: Colors.white,
                                  size: 25.0,
                                ),
                                radius: 20.0,
                              ),
                              onTap: () async {
                                const url = 'https://ar-ar.facebook.com/AlAzharTC/';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                            ),
                            Padding(padding: EdgeInsets.only(right: 30.0)),
                            InkWell(
                              child: new CircleAvatar(
                                backgroundColor: Colors.purple,
                                child: new Icon(
                                  MdiIcons.instagram, color: Colors.white,
                                  size: 25.0,
                                ),
                                radius: 20.0,
                              ),
                              onTap: () async {
                                const url = '';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                            ),
                            Padding(padding: EdgeInsets.only(right: 30.0)),
                            InkWell(
                              child: new CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: new Icon(
                                  MdiIcons.linkedin, color: Colors.white,
                                  size: 25.0,
                                ),
                                radius: 20.0,
                              ),
                              onTap: () async {
                                const url = '';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                            ),
                          ],),
                        new Divider(
                          height: _height / 30, color: Colors.blue),
                        new Padding(
                          padding: new EdgeInsets.only(left: _width / 8,
                            right: _width / 8),
                          child: new FlatButton(onPressed: () {},
                            child: new Container(child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Icon(
                                  MdiIcons.whatsapp, color: Colors.white,),
                                new SizedBox(width: _width / 30,),
                                new Text('Contact Us\n0123456789',
                                  style: TextStyle(color: Colors.white),),
                              ],)), color: Colors.indigo[900],),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]
    );
  }
  
  Widget rowCell(int count, String type) =>
    new Expanded(child: new Column(children: <Widget>[
      new Text('$count', style: new TextStyle(color: Colors.white),),
      new Text(type,
        style: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
    ],));
  
  Widget _buildPlaceToVisit({String image, String title,}) {
    return Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.asset(image, height: 80, width: 80, fit: BoxFit.cover,),
        ),
        SizedBox(height: 5.0,),
        Text(title)
      ],
    );
  }

//  _onTapItem(BuildContext pcontext, int index) {
//   Navigator.of(pcontext).push(MaterialPageRoute<void>(
//       builder: (BuildContext context) {
//         return Scaffold(
//           appBar: AppBar(
//             title:  Text('${title[index%title.length]} committee'),
//           ),
//           body: Material(
//             child: Container(
//               // The blue background emphasizes that it's a new route.
//               color: Colors.white,
//               padding: const EdgeInsets.all(16.0),
//               alignment: Alignment.topLeft,
//               child: GestureDetector(
//                 onTap: () => Navigator.pop(context),
//                 child: Column(
//                   children: <Widget>[
//                     Expanded(child: Hero(
//                         tag:"item$index",
//                         child:  Image.network(userData[index]["image"], alignment: Alignment.center,
//                             width: 200.0,
//                             height: 200.0,))),
//                     SizedBox(height: 3.0,),
//                     Text(" ${userData[index]["title"]}", softWrap: true,),
//                     SizedBox(height: 10.0,),
//                     Text(" ${userData[index]["url"]}", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.red),)
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       }
//   ));
// }

}





