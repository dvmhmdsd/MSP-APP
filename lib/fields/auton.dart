import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:msp_app/ui/colors.dart';

class auton extends StatefulWidget {
  @override
  mediaState createState() => new mediaState();
}

class mediaState extends State<auton> {
  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "https://my-json-server.typicode.com/salah-rashad/msp-json/sessions"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    print(data[1]["title"]);

    return "Success!";
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data == null ? 0 : data.length,
        padding: EdgeInsets.all(16),
        itemBuilder: (BuildContext context, int index) {
          return Card(
              margin: EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: purple)),
              child: Container(
                padding: EdgeInsets.only(top: 7, bottom: 7),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.network(
                      (data[index]["image"]),
                      width: 100,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "${data[index]["title"]} ",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        });
  }
}
