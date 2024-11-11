import 'dart:io';
import 'package:dio/dio.dart';
import 'package:social_media_app/models/comment_model.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/models/user_model.dart';
import '../Exceptions/app_exceptions.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<PostModel>> fetchPosts() async {
    try {
      final response =
          await _dio.get('https://jsonplaceholder.typicode.com/posts');
      List data = handleResponse(response);
      return data.map((post) => PostModel.fromJson(post)).toList();
    } on DioException catch (e) {
      return Future.error(_handleDioError(e));
    }
  }

  Future<List<CommentModel>> fetchComments() async {
    try {
      final response =
          await _dio.get('https://jsonplaceholder.typicode.com/comments');
      List data = handleResponse(response);
      return data.map((comment) => CommentModel.fromJson(comment)).toList();
    } on DioException catch (e) {
      return Future.error(_handleDioError(e));
    }
  }

  Future<List<UserModel>> fetchUser() async {
    try {
      final response =
          await _dio.get('https://jsonplaceholder.typicode.com/users');
      List data = handleResponse(response);
      return data.map((user) => UserModel.fromJson(user)).toList();
    } on DioException catch (e) {
      return Future.error(_handleDioError(e));
    }
  }

  dynamic handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 400:
        throw BedRequestException('Invalid Request');

      case 408:
        throw TimeOutException("Request timed out");
      case 504:
        throw InvalidResponceException("Server error");
      default:
        throw AppException(
            "Unexpected error", "Error ${response.statusCode}: ");
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.type == DioExceptionType.unknown && e.error is SocketException) {
      throw NetworkException("Please check your internet connection.");
    } else {
      throw TimeOutException("Connection timed out. Please try again later.");
    }
  }
}
