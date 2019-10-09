import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

String apiURL = "https://msp-app-dashboard.herokuapp.com/api/courses";

class Sessions extends StatefulWidget {
  @override
  _SessionsState createState() => _SessionsState();
}

class _SessionsState extends State<Sessions> {
  List data;
  List sessions;
  
  Future getData() async {
    http.Response response =
    await http.get(apiURL);
    data = json.decode(response.body);
    setState(() {
      sessions = data;
    });
  }
  
  @override
  void initState() {
    super.initState();
    getData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: http.get(apiURL),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (sessions.length == 0) {
                return Center(
                  child: Text("No Sessions Available Yet."),
                );
              }
              if (snapshot.hasError)
                return new Center(
                  child: Text(
                    "An error occurred, please check your internet connection!"),
                );
              else
                return new ListView.builder(
                  padding: EdgeInsets.all(16.0),
                  itemCount: sessions == null ? 0 : sessions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.white,
                      elevation: 1.0,
                      margin: EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.black)),
                      child: InkWell(
                        onTap: () async {
                          var url = sessions[index]["courseLink"];
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(children: <Widget>[
//
                            // Container(
                            //   decoration: BoxDecoration(
                            //       border: Border.all(color: Colors.white70),
                            //       borderRadius: BorderRadius.all(Radius.circular(20))),
                            //   child: Image.network(
                            //     sessions[index]["image"],
                            //     fit: BoxFit.cover,
                            //     alignment: Alignment.centerRight,
                            //     width: 100.0,
                            //     height: 60.0,
                            //   ),
                            // ),
                            // Padding(padding: EdgeInsets.all(30.0)),
                            new Text(
                              " ${sessions[index]["name"]}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ]),
                        ),
                      ),
                    );
                  });
          }
          
          // sessions.length == 0;
          // return snapshot.hasData
          //     ?
          //     : Center(
          //         child: Text("No Sessions Available Yet."),
          //       );
        },
      ));
  }
}
