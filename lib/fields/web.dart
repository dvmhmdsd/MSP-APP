import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:msp_app/pages/project.dart';
import 'package:msp_app/ui/colors.dart';

const baseUrl = "https://my-json-server.typicode.com/salah-rashad/msp-json";

class API {
  static Future getUsers() {
    var url = baseUrl + "/events";
    return http.get(url);
  }
}

class project {
  final int id;
  final String title;
  final String url;
  final String description;
  final String image;
  final List<Staff> staff;

  project(
      {this.id,
      this.title,
      this.url,
      this.description,
      this.image,
      this.staff});

  factory project.fromJson(Map<String, dynamic> json) {
    var list = json['staff'] as List;
    print(list.runtimeType); //returns List<dynamic>
    List<Staff> staffList = list.map((i) => Staff.fromJson(i)).toList();
    return project(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      description: json['description'],
      image: json['image'],
      staff: staffList,
    );
  }
}

class Staff {
  final String name;
  final String image;

  Staff({this.name, this.image});

  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      name: json['name'],
      image: json['image'],
    );
  }
}

class web extends StatefulWidget {
  final Future<project> Project;

  web({Key key, this.Project}) : super(key: key);

  @override
  webState createState() => new webState();
}

class webState extends State<web> {
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
                  project_link: Project.url,
                  project_staff: Project.staff,
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
                  Image.network(
                    Project.image,
                    width: 100,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
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
