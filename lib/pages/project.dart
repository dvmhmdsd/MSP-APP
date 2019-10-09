import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class projects extends StatefulWidget {
  final project_id;
  final project_title;
  final project_image;
  final project_description;
  final project_link;
  final project_staff;

  projects({
    this.project_id,
    this.project_title,
    this.project_image,
    this.project_description,
    this.project_link,
    this.project_staff,
  });

  @override
  _projectsState createState() => _projectsState();
}

class _projectsState extends State<projects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.project_title,
          style: TextStyle(color: Colors.grey.shade800),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: new ListView(
        children: <Widget>[
          Container(
              height: 200,
              width: double.infinity,
              child: Builder(builder: (context) {
                if (widget.project_image == null) {
                  return new Container();
                } else {
                  var img = widget.project_image
                      .replaceAll("data:image/jpeg;base64,", "");
                  Uint8List bytes = base64.decode(img);
                  return Image.memory(
                    bytes,
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  );
                }
              })),
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, top: 16.0, right: 16.0, bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Description",
                  style: Theme.of(context).textTheme.title,
                ),
                Divider(),
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  widget.project_description,
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
