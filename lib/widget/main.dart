import 'package:flutter/material.dart';
import 'package:flutter_posts/data/repository.dart';
import 'package:flutter_posts/widget/list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Post list',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
          primaryColor: Colors.blue,
          accentColor: Colors.white,
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            title: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
            body1: TextStyle(fontSize: 12.0, fontFamily: 'Hind'),
          ),
          fontFamily: 'Montserrat'),
      home: PostListScreen(Repository()),
      debugShowCheckedModeBanner: false,
    );
  }
}
