import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/Api/controller/getxcontroller.dart';
import 'package:social_media_app/models/app_data.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({
    super.key,
  });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final GetController userController = Get.put(GetController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('User Profile'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Obx(() {
        if (userController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (userController.errorMessage.isNotEmpty) {
          return Center(child: Text('Error: ${userController.errorMessage}'));
        }

        final users = AppData().getuser();

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final userId = user.id;

            return Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name ?? 'No Name',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    InfoRow(
                      label: "Email",
                      value: user.email ?? 'N/A',
                      icon: Icons.email,
                    ),
                    InfoRow(
                      label: "Phone",
                      value: user.phone ?? 'N/A',
                      icon: Icons.phone,
                    ),
                    InfoRow(
                      label: "Website",
                      value: user.website ?? 'N/A',
                      icon: Icons.web,
                    ),
                    const Divider(),
                    InfoRow(
                      label: "Company",
                      value: user.company?.name ?? 'N/A',
                      icon: Icons.business,
                    ),
                    const SizedBox(height: 8),
                    InfoRow(
                      label: "Address",
                      value:
                          '${user.address?.street ?? ''}, ${user.address?.city ?? ''}',
                      icon: Icons.location_on,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "User ID: $userId",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
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

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blueGrey),
          const SizedBox(width: 8),
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
