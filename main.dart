// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, library_private_types_in_public_api, prefer_collection_literals, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class News {
  String id;
  String url;
  String title;
  String text;
  String publisher;
  String author;
  String image;
  String date;

  News(
    this.id,
    this.url,
    this.title,
    this.text,
    this.publisher,
    this.author,
    this.image,
    this.date,
  );

  News.fromJson(Map<String, dynamic> json, this.id, this.url, this.author,
      this.date, this.image, this.publisher, this.text, this.title) {
    id = json['id'];
    url = json['url'];
    title = json['title'];
    publisher = json['publisher'];
    author = json['author'];
    image = json['image'];
    date = json['date'];
  }
}

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

void main() {
  runApp(NewsApp());
}

class _HomePageState extends State<HomePage> {
  static List<News> news = <News>[];
  static List<News> newsInApp = <News>[];
  
  

  Future<List<News>> comingNews() async {
    var url = 'https://newsapi.org/';
    var response = await http.get(Uri.parse(url));
    var news = <News>[];


    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        news.add(News.fromJson(noteJson,newsjson.id,newsjson.url,title,author,publisher,image,date,text));
      }
    }
    return news;
  }

  @override
  void initState() {
    comingNews().then((value) {
      setState(() {
        news.addAll(value);
        newsInApp = news;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: Column(children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border(
                  bottom: BorderSide(
                width: 0.5,
                color: Colors.black,
              )),
            ),
            child: AppBar(
              title: Text(
                'STAR-LIGHT NEWS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
