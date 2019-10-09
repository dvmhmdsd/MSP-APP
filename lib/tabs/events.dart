import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:msp_app/ui/colors.dart';
import 'package:url_launcher/url_launcher.dart';

const String apiURL = "https://msp-app-dashboard.herokuapp.com/api/events";


class API {
  static Future getEvents() {
    return http.get(apiURL);
  }
}

class Event {
  final String id;
  final String title;
  final String description;
  final String price;
  final String location;
  final String formLink;
  final String date;
  final String time;
  final String img;
  final List<Topic> topics;

  Event({
    this.id,
    this.title,
    this.description,
    this.price,
          this.location,
          this.formLink,
          this.date,
          this.time,
          this.img,
    this.topics,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    var list = json['topics'] as List;
    print(list.runtimeType); //returns List<dynamic>
    List<Topic> topicsList = list.map((i) => Topic.fromJson(i)).toList();

    return Event(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      location: json['location'],
      formLink: json['formLink'],
      date: json['date'],
      time: json['time'],
      img: json['imgURL'],
      topics: topicsList,
    );
  }
}

class Topic {
  final String title;
  final String sName;
  final String sJob;

  Topic({this.title, this.sName, this.sJob});

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      title: json['title'],
      sName: json['speakerName'],
      sJob: json['speakerJob'],
    );
  }
}

class Events extends StatefulWidget {
  final Future<Event> event;

  Events({Key key, this.event}) : super(key: key);

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  var events = new List<Event>();
  Future<Event> event;

  _getEvents() {
    API.getEvents().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        events = list.map((model) => Event.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getEvents();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: http.get(apiURL), // async work
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (events.length == 0) {
              return Center(
                child: Text("No Events Available Yet."),
              );
            }
            if (snapshot.hasError)
              return new Center(
                child: Text(
                  "An error occurred, please check your internet connection!"),
              );
            else
              return new ListView.builder(
                padding: EdgeInsets.all(16),
                itemBuilder: (BuildContext context, int i) =>
                  EventItem(events[i]),
                itemCount: events.length,
              );
        }
      });
    // return ListView.builder(
    //   padding: EdgeInsets.all(16),
    //   itemBuilder: (BuildContext context, int i) => EventItem(events[i]),
    //   itemCount: events.length,
    // );
  }
}

class EventItem extends StatelessWidget {
  const EventItem(this.event);

  final Event event;

  Widget _buildEventCard(BuildContext context, Event event) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: purple)),
      child: Container(
        padding: EdgeInsets.only(top: 16, bottom: 16),
        child: ExpansionTile(
          title: Text(event.title),
          leading: ClipOval(child: Builder(builder: (context) {
            if (event.img == null) {
              return new Container();
            } else {
              var img = event.img.replaceAll("data:image/jpeg;base64,", "");
              Uint8List bytes = base64.decode(img);
              return Image.memory(
                bytes,
                fit: BoxFit.cover,
                height: 60,
                width: 56,
                alignment: Alignment.center,
              );
            }
          })),
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(top: 32, right: 16, left: 16),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 4,
                          child: Text(
                            "Description".toUpperCase(),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            event.description,
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 4,
                          child: Text(
                            "Date & Time".toUpperCase(),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                        ),
                        Flexible(
                          child: Builder(builder: (context) {
                            var date =
                            DateFormat("dd/MM/yyyy - hh:mm a").format(
                              DateTime.parse("${event.date} ${event.time}"),
                            );
                            return Text(date);
                          }),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 4,
                          child: Text(
                            "Location".toUpperCase(),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                        ),
                        Flexible(
                          child: GestureDetector(
                            onTap: () => launchURL(event.location),
                            child: Text(
                              "Open Google Maps",
                              style: TextStyle(
                                color: blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Builder(builder: (context) {
                      if (event.topics.length > 0) {
                        return ExpansionTile(
                          title: Text(
                            "Topics".toUpperCase(),
                            style: TextStyle(fontSize: 14),
                          ),
                          leading: Icon(Icons.library_books),
                          backgroundColor: Colors.black.withOpacity(0.05),
                          children: <Widget>[
                            Container(
                              height: 250,
                              child: ListView.builder(
                                itemCount: event.topics.length,
                                itemBuilder:
                                  (BuildContext context, int index) {
                                  return _buildTopicItem(index);
                                }),
                            )
                          ],
                        );
                      } else {
                        return Container();
                      }
                    }),
                    ButtonTheme(
                      child: ButtonBar(
                        alignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(text: "Ticket Price: ".toUpperCase()),
                                TextSpan(
                                  text: event.price.toString(),
                                  style:
                                  TextStyle(color: green, fontSize: 18)),
                                TextSpan(text: " L.E"),
                              ],
                            ),
                          ),
                          RaisedButton(
                            colorBrightness: Brightness.dark,
                            color: purple,
                            child: Text(
                              'Enroll'.toUpperCase(),
                              style: TextStyle(color: white),
                            ),
                            onPressed: () => launchURL(event.formLink),
                          ),
                        ],
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildTopicItem(int i) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            (i + 1).toString() + "- " + event.topics[i].title.toUpperCase(),
            style: TextStyle(
              fontSize: 16, color: blue, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 25,
              ),
              Text(
                "• " + event.topics[i].sName.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 35,
              ),
              Flexible(
                child: Text(
                  event.topics[i].sJob,
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
              )
            ],
          ),
//          Text(
//            "     • " + event.topics[i].sName,
//          ),
//          Text(
//            "       " + event.topics[i].sDesc,
//          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildEventCard(
      context,
      event,
    );
  }
}

launchURL(String url) async {
  String mUrl = url;
  if (await canLaunch(mUrl)) {
    await launch(mUrl);
  } else {
    throw 'Could not launch $mUrl';
  }
}
