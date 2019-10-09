import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:msp_app/pages/project.dart';
import 'package:msp_app/ui/colors.dart';

const baseUrl = "https://msp-app-dashboard.herokuapp.com/api";

class API {
  static Future getUsers() {
    var url = baseUrl + "/events";
    return http.get(url);
  }
}

class project {
  final int id;
  final String title;
  final String time;
  final String location;
  final String url;
  final String description;
  final String image;

  project({
    this.id,
    this.title,
    this.time,
    this.location,
    this.url,
    this.description,
    this.image,
  });

  factory project.fromJson(Map<String, dynamic> json) {
    return project(
      id: json['id'],
      title: json['title'],
      time: json['time'],
      location: json['location'],
      url: json['url'],
      description: json['description'],
      image: json['imgURL'],
    );
  }
}

class media extends StatefulWidget {
  final Future<project> Project;

  media({Key key, this.Project}) : super(key: key);

  @override
  mediaState createState() => new mediaState();
}

class mediaState extends State<media> {
  var projects = new List<project>();
  Future<project> Project;

  _getprojects() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        projects = list.map((model) => project.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getprojects();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemBuilder: (BuildContext context, int i) => projectItem(projects[i]),
      itemCount: projects.length,
    );
  }
}

class projectItem extends StatelessWidget {
  const projectItem(this.Project);

  final project Project;

  Widget _buildProjectCard(BuildContext context, project Project) {
    return new GestureDetector(
        onTap: () => Navigator.of(context).push(new MaterialPageRoute(
            builder: (context) => new projects(
                  project_title: Project.title,
                  project_image: Project.image,
                  project_description: Project.description,
                ))),
        child: Card(
            margin: EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: purple)),
            child: Container(
              padding: EdgeInsets.only(top: 7, bottom: 7),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipOval(child: Builder(builder: (context) {
                    if (Project.image == null) {
                      return new Container();
                    } else {
                      var img = Project.image
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
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      Project.title,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return _buildProjectCard(
      context,
      Project,
    );
  }
}
