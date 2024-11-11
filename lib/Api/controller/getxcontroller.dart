import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:social_media_app/Api/api_service.dart';
import 'package:social_media_app/models/app_data.dart';

import 'package:social_media_app/utils/utils.dart';
import '../../exceptions/app_exceptions.dart';

class GetController extends GetxController {
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  final ApiService apiService = ApiService();
  final Dio _dio = Dio();

  Future<dynamic> addpost(String title, String body) async {
    try {
      final responce =
          await _dio.post('https://jsonplaceholder.typicode.com/posts', data: {
        'title': title,
        'body': body,
      });
      if (responce.statusCode == 201) {
        Utils.showToast('post added successfully');
      }
    } catch (e) {
      Utils.showToast(e.toString());
    }
  }

  Future<void> fetchPosts() async {
    try {
      isLoading(true);
      errorMessage('');
      var fetchedPosts = await apiService.fetchPosts();
      AppData().setPosts(fetchedPosts);
    } on NetworkException catch (e) {
      errorMessage(e.message);
    } on TimeOutException catch (e) {
      errorMessage(e.message);
    } on BedRequestException catch (e) {
      errorMessage(e.message);
    } on InvalidResponceException catch (e) {
      errorMessage(e.message);
    } on AppException catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchComments() async {
    try {
      isLoading(true);
      errorMessage('');
      var fetchedComments = await apiService.fetchComments();
      AppData().setComments(fetchedComments);
    } on NetworkException catch (e) {
      errorMessage(e.message);
    } on TimeOutException catch (e) {
      errorMessage(e.message);
    } on BedRequestException catch (e) {
      errorMessage(e.message);
    } on InvalidResponceException catch (e) {
      errorMessage(e.message);
    } on AppException catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchUser() async {
    try {
      isLoading(true);
      errorMessage('');
      var fetchedUser = await apiService.fetchUser();
      AppData().setuser(fetchedUser);
    } on NetworkException catch (e) {
      errorMessage(e.message);
    } on TimeOutException catch (e) {
      errorMessage(e.message);
    } on BedRequestException catch (e) {
      errorMessage(e.message);
    } on InvalidResponceException catch (e) {
      errorMessage(e.message);
    } on AppException catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    fetchPosts();
    fetchComments();
    fetchUser();
    super.onInit();
  }
}
