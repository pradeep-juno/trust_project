import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jk_event/controller/login_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../router/routers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LoginController loginController = Get.put(LoginController());

  String mobile = '';
  String password = '';
  String id = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mobile = prefs.getString('mobile') ?? 'Not Available';
      password = prefs.getString('password') ?? 'Not Available';
      id = prefs.getString('id') ?? 'Not Available';
    });

    print("AdminId : $id");

    // Listen to admin data updates after loading user data
    loginController.listenAdminDataUpdates(context, id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Hello")),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                // Clear SharedPreferences on logout
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();

                Get.offNamed(AppRouter.LOGIN_SCREEN);
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome to the Home Screen!"),
              const SizedBox(height: 20),
              Obx(() {
                return Text("Mobile: ${loginController.mobileNumber.value}");
              }),
              const SizedBox(height: 10),
              Obx(() {
                return Text("Password: ${loginController.password.value}");
              }),
            ],
          ),
        ),
      ),
    );
  }
}
