import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:msp_app/pages/Project.dart';
import 'package:msp_app/ui/colors.dart';

const baseUrl = "https://msp-app-dashboard.herokuapp.com/api";

class API {
  static Future getUsers() {
    var url = baseUrl + "/events";
    return http.get(url);
  }
}

class Project {
  final int id;
  final String title;
  final String time;
  final String location;
  final String url;
  final String description;
  final String image;

  Project({
    this.id,
    this.title,
    this.time,
    this.location,
    this.url,
    this.description,
    this.image,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
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

class mobile extends StatefulWidget {
  final Future<Project> project;

  mobile({Key key, this.project}) : super(key: key);

  @override
  mobileState createState() => new mobileState();
}

class mobileState extends State<mobile> {
  var projects = new List<Project>();
  Future<Project> project;

  _getprojects() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        projects = list.map((model) => Project.fromJson(model)).toList();
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
      itemBuilder: (BuildContext context, int i) => ProjectItem(projects[i]),
      itemCount: projects.length,
    );
  }
}

class ProjectItem extends StatelessWidget {
  const ProjectItem(this.project);

  final Project project;

  Widget _buildProjectCard(BuildContext context, Project project) {
    return new GestureDetector(
        onTap: () => Navigator.of(context).push(new MaterialPageRoute(
            builder: (context) => new projects(
                  project_title: project.title,
                  project_image: project.image,
                  project_description: project.description,
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
                    if (project.image == null) {
                      return new Container();
                    } else {
                      var img = project.image
                          .replaceAll("data:image/jpeg;base64,", "");
                      Uint8List bytes = base64.decode(img);
                      return Image.memory(
                        bytes,
                        height: 60,
                        width: 60,
                      );
                    }
                  })),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      project.title,
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
      project,
    );
  }
}
