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
      appBar: AppBar(
          title: StreamBuilder<PostDetailsViewState>(
              stream: _postBloc.post,
              builder: (context, snapshot) {
                if (snapshot.data is PostDetailsDataState) {
                  return _buildDetailsView(snapshot.data);
                }
              })),
    );
  }

  Widget _buildDetailsView(PostDetailsDataState data) {
    PostModel _post = data.postDetails;
    return Text(_post.title)
  }
}
