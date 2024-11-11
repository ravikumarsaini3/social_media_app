import 'package:social_media_app/models/comment_model.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/models/user_model.dart';

class AppData {
  AppData._internal();

  static final AppData _instance = AppData._internal();

  factory AppData() => _instance;

  List<CommentModel> comments = [];
  List<UserModel> user = [];
  List<PostModel> posts = [];

  void setPosts(List<PostModel> newPosts) {
    posts = newPosts;
  }

  void setComments(List<CommentModel> newComments) {
    comments = newComments;
  }

  void setuser(List<UserModel> newuser) {
    user = newuser;
  }

  List<PostModel> getPosts() {
    return posts;
  }

  List<CommentModel> getcomment() {
    return comments;
  }

  List<UserModel> getuser() {
    return user;
  }
}
