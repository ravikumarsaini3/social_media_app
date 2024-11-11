import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:social_media_app/Api/controller/getxcontroller.dart';
import 'package:social_media_app/Screens/post_details_screen.dart';
import 'package:social_media_app/models/app_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GetController postController = Get.put(GetController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            const Text('Posts', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Obx(() {
        if (postController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (postController.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              'Error: ${postController.errorMessage}',
              style: const TextStyle(color: Colors.red, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          );
        }
        final posts = AppData().getPosts();
        if (posts.isEmpty) {
          return const Center(
              child: Text(
                  'No posts available please refersh and check Internet '));
        }

        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PostDetailsScreen(),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.account_circle,
                              size: 40, color: Colors.blueAccent),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              post.title ?? 'No Title',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey.shade900,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Divider(color: Colors.grey.shade300),
                      const SizedBox(height: 10),
                      Text(
                        post.body ?? 'No Content',
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade700),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Post ID: ${post.id}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const Icon(Icons.thumb_up_alt_outlined,
                              color: Colors.blueAccent, size: 20),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPostDialog(context),
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddPostDialog(BuildContext context) {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Post'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: bodyController,
                decoration: const InputDecoration(labelText: 'Body'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final title = titleController.text;
                final body = bodyController.text;
                postController.addpost(title, body);
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
