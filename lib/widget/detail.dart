import 'package:flutter/material.dart';
import 'package:flutter_posts/data/repository.dart';
import 'package:flutter_posts/model/comment_model.dart';
import 'package:flutter_posts/model/post_model.dart';
import 'package:flutter_posts/postdetailbloc.dart';

class PostDetailScreen extends StatefulWidget {
  PostDetailScreen(this._repository, this._post);

  final Repository _repository;
  final PostModel _post;

  @override
  State<StatefulWidget> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  PostDetailsBloc _detailsBloc;

  @override
  void initState() {
    _detailsBloc = PostDetailsBloc(widget._repository);
    _detailsBloc.getComments(widget._post.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      _buildDetailsView(widget._post),
      new AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      )
    ]));
  }

  Widget _buildDetailsView(PostModel post) {
    return new Container(
        child: new Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        getAvatar(post),
        getTitle(post),
        getBody(post),
        new SafeArea(
            child: StreamBuilder<PostDetailsViewState>(
                initialData: PostDetailsLoadingState(),
                stream: _detailsBloc.comments,
                builder: (context, snapshot) {
                  if (snapshot.data is PostDetailsLoadingState) {
                    return _buildLoading();
                  }

                  if (snapshot.data is PostDetailsDataState) {
                    return _buildCommentsView(snapshot.data);
                  }

                  if (snapshot.data is PostDetailsErrorState) {
                    return Container();
                  }
                }))
      ],
    ));
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildCommentsView(PostDetailsDataState data) {
    CommentModelList _comments = data.comments;
    return ListView.builder(
        itemCount: _comments.comments.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, position) {
          return _buildCommentItem(_comments.comments[position]);
        });
  }

  Widget _buildCommentItem(CommentModel comment) {
    return new Card(
      child: new Row(
        children: [
          Expanded(
              child: new Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
                  child: Text(comment.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12))),
              Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Text(
                    comment.body,
                    style: TextStyle(fontSize: 12),
                  ))
            ],
          ))
        ],
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ))));
  }

  Hero getBody(PostModel post) {
    return Hero(
        tag: "${post.id}body",
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Material(
                child: Text(
              post.body,
              textAlign: TextAlign.left,
            ))));
  }

  @override
  void dispose() {
    _detailsBloc.dispose();
    super.dispose();
  }
}
