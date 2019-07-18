import 'package:flutter/material.dart';
import 'package:flutter_posts/data/repository.dart';
import 'package:flutter_posts/model/post_model.dart';
import 'package:flutter_posts/postdetailbloc.dart';

class PostDetailScreen extends StatefulWidget {
  PostDetailScreen(this._repository, this._postId);

  final Repository _repository;
  final int _postId;

  @override
  State<StatefulWidget> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  PostDetailsBloc _postBloc;

  @override
  void initState() {
    _postBloc = PostDetailsBloc(widget._repository);
    _postBloc.getPost(widget._postId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      new SafeArea(
          child: StreamBuilder<PostDetailsViewState>(
              stream: _postBloc.post,
              builder: (context, snapshot) {
                if (snapshot.data is PostDetailsDataState) {
                  return _buildDetailsView(snapshot.data);
                }
              })),
      new AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      )
    ]));
  }

  Widget _buildDetailsView(PostDetailsDataState data) {
    PostModel _post = data.postDetails;
    return new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [getAvatar(_post), getTitle(_post), getBody(_post)],
      ),
    );
  }

  Hero getAvatar(PostModel post) {
    return Hero(
        tag: post.id,
        child: Image.network(
            "https://api.adorable.io/avatars/500/${post.userId}",
            fit: BoxFit.cover,
            height: 300));
  }

  Hero getTitle(PostModel post) {
    return Hero(
        tag: "${post.id}title",
        child: Padding(
            padding: EdgeInsets.fromLTRB(16, 32, 16, 0),
            child: Material(
                child: Text(
              post.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ))));
  }

  Hero getBody(PostModel post) {
    return Hero(
        tag: "${post.id}body",
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              post.body,
              textAlign: TextAlign.left,
            )));
  }
}
