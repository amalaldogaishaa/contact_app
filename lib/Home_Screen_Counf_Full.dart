import 'dart:io';
import 'package:contact_app/UserData.dart';
import 'package:contact_app/bottom_nav_bar_screen.dart';
import 'package:contact_app/colors.dart';
import 'package:flutter/material.dart';

class HomeScreenCounfFull extends StatefulWidget {
  static const String routeName = '/counFull';
  final List<User> users;

  const HomeScreenCounfFull({super.key, required this.users});

  @override
  State<HomeScreenCounfFull> createState() => _HomeScreenCounfFullState();
}

class _HomeScreenCounfFullState extends State<HomeScreenCounfFull> {
  late List<User> _users;

  @override
  void initState() {
    super.initState();
    final defaultUsers = <User>[
      User(
        name: 'Leo Messi',
        email: 'leomessi.route@gmail.com',
        phoneNumber: '+20000000000',
        imageUrl: "assets/images/model1.jpg",
        uniqueId: '1',
      ),
      User(
        name: 'El-balf',
        email: 'elbalf.route@gmail.com',
        phoneNumber: '+201666666666',
        imageUrl: 'assets/images/model3.jpg',
        uniqueId: '2',
      ),
      User(
        name: 'GOAT',
        email: 'leomessi.route@gmail.com',
        phoneNumber: '+20000000000',
        imageUrl: 'assets/images/model4.png',
        uniqueId: '3',
      ),
      User(
        name: 'Another User',
        email: 'anotheruser.route@gmail.com',
        phoneNumber: '+20000000000',
        imageUrl: 'assets/images/model2.jpg',
        uniqueId: '4',
      ),
    ];

    _users = [...defaultUsers];
    for (var user in widget.users) {
      if (!_users.any((u) => u.uniqueId == user.uniqueId)) {
        _users.add(user);
      }
    }
  }

  void _deleteUser(String uniqueId) {
    setState(() {
      _users.removeWhere((user) => user.uniqueId == uniqueId);
    });
  }

  void _deleteLastUser() {
    if (_users.isEmpty) return;
    setState(() {
      _users.removeLast();
    });
  }

  void showAddContactSheet(BuildContext context) async {
    if (_users.length >= 6) return;

    final newUser = await showModalBottomSheet<User>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => BottomNavBarScreen(),
    );

    if (newUser != null && !_users.any((u) => u.uniqueId == newUser.uniqueId)) {
      setState(() {
        _users.add(newUser);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_users.isEmpty) {
      Future.microtask(() {
        Navigator.popAndPushNamed(context, '/home');
      });
      return const SizedBox.shrink();
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        title: Image.asset("assets/images/logo.png", width: 100),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(15.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 15.0,
          childAspectRatio: 0.6,
        ),
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return _buildContactCard(user);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_users.isNotEmpty)
            FloatingActionButton(
              heroTag: 'delete_last_fab',
              onPressed: _deleteLastUser,
              backgroundColor: AppColors.errorColors,
              foregroundColor: AppColors.textColors,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              tooltip: 'Delete Last User',
              child: const Icon(Icons.delete),
            ),
          if (_users.isNotEmpty) const SizedBox(height: 15),
          if (_users.length < 6)
            FloatingActionButton(
              heroTag: 'add_user',
              onPressed: () => showAddContactSheet(context),
              backgroundColor: AppColors.buttonsColors,
              foregroundColor: AppColors.background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              tooltip: 'Add New User',
              child: const Icon(Icons.add),
            ),
          if (_users.isNotEmpty) const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _buildContactCard(User user) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.buttonsColors,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.background, width: 0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: user.imageUrl.startsWith('http')
                      ? Image.network(
                          user.imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        )
                      : user.imageUrl.startsWith('/')
                      ? Image.file(
                          File(user.imageUrl),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        )
                      : Image.asset(
                          user.imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.buttonsColors,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      user.name,
                      style: const TextStyle(
                        color: AppColors.background,
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.email,
                      color: AppColors.background,
                      size: 18,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        user.email,
                        style: const TextStyle(
                          color: AppColors.background,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      color: AppColors.background,
                      size: 18,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        user.phoneNumber,
                        style: const TextStyle(
                          color: AppColors.background,
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _deleteUser(user.uniqueId),
                    icon: const Icon(Icons.delete, size: 18),
                    label: const Text('Delete'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.errorColors,
                      foregroundColor: AppColors.textColors,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
