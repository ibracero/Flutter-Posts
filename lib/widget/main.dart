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
      ),
      home: PostListScreen(Repository()),
      debugShowCheckedModeBanner: false,
    );
  }
}