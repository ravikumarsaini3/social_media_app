import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Api/controller/getxcontroller.dart';
import '../models/app_data.dart';
import 'user_profile_screen.dart';

class PostDetailsScreen extends StatefulWidget {
  const PostDetailsScreen({super.key});

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  final GetController postDetailsController = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Post Details',
          style: TextStyle(),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Obx(() {
        if (postDetailsController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (postDetailsController.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              'Error: ${postDetailsController.errorMessage}',
              style: const TextStyle(color: Colors.red, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          );
        }

        final posts = AppData().getPosts();
        final comments = AppData().getcomment();

        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int index) {
            final post = posts[index];
            final postComments =
                comments.where((comment) => comment.postId == post.id).toList();

            return Card(
              margin: const EdgeInsets.all(12),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   
                    Text(
                      post.title ?? 'No Title',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      post.body ?? 'No Content',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserProfileScreen(),
                          ),
                        );
                      },
                      child: const Text("View User Profile"),
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.comment, color: Colors.grey.shade600),
                        const SizedBox(width: 5),
                        Text(
                          'Comments',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ...postComments.map((comment) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.blueAccent,
                                        child: Text(
                                          comment.name
                                                  ?.substring(0, 1)
                                                  .toUpperCase() ??
                                              'A',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          comment.name ?? 'No Name',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    comment.email ?? 'No Email',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    comment.body ?? 'No Comment',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
