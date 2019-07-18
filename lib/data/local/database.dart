import 'dart:io';

import 'package:flutter_posts/model/post_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const String TABLE_POST = 'Post';
  static const String COLUMN_ID = 'id';
  static const String COLUMN_USER_ID = 'user_id';
  static const String COLUMN_TITLE = 'title';
  static const String COLUMN_BODY = 'body';

  //Private constructor
  DatabaseHelper._();

  static final DatabaseHelper db = DatabaseHelper._();

  static Database _database;

  Future<Database> get database async {
    if (_database == null) _database = await initDatabase();

    return _database;
  }

  initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "PostDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $TABLE_POST ("
          "$COLUMN_ID INTEGER PRIMARY KEY,"
          "$COLUMN_USER_ID INTEGER,"
          "$COLUMN_TITLE TEXT,"
          "$COLUMN_BODY TEXT"
          ")");
    });
  }

  void insertOrUpdate(PostModelList postList) async {
    final db = await database;
    Batch batch = db.batch();
    for (var post in postList.posts) {
      batch.insert(TABLE_POST, post.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    batch.commit(noResult: true);
  }

  Future<PostModelList> getPosts() async {
    final db = await database;
    return db.query(TABLE_POST).then((posts) => PostModelList.fromMap(posts));
  }

  Future<PostModel> getPost(int postId) async {
    final db = await database;
    return db
        .query(TABLE_POST, where: "id = $postId")
        .then((posts) => PostModel.fromMap(posts[0]));
  }
}
