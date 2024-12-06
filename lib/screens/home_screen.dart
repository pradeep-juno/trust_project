import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jk_event/controller/login_controller.dart';
import 'package:jk_event/utils/constants.dart';
import 'package:jk_event/utils/functions.dart';
import 'package:jk_event/utils/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../router/routers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String id = '';

    setState(() {
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Obx(() {
            // Extract first two letters of the name
            String initials = loginController.adminName.value.isNotEmpty
                ? loginController.adminName.value.substring(0, 2).toUpperCase()
                : "--";

            return Row(
              children: [
                buildCircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blue,
                    text: initials,
                    color: Colors.white,
                    fontweight: FontWeight.bold),

                const SizedBox(width: 10), // Space between avatar and text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTextFun(context,
                        title:
                            "${AppConstant.hi}, ${loginController.adminName.value}!",
                        fontsize: 18,
                        fontweight: FontWeight.bold,
                        color: Colors.black),
                    buildTextFun(context,
                        title: "${loginController.mobileNumber.value}",
                        fontsize: 14,
                        fontweight: FontWeight.normal,
                        color: Colors.black),
                  ],
                ),
                buildSizedBoxWidthFun(context, width: 350),
                buildTextFun(context,
                    title: AppConstant.ajayTrust,
                    fontsize: 30,
                    fontweight: FontWeight.bold,
                    color: Colors.red)
              ],
            );
          }),
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
              Obx(() {
                return buildTextFun(context,
                    title:
                        "${AppConstant.hi}, ${loginController.adminName.value}!",
                    fontsize: 18,
                    fontweight: FontWeight.bold,
                    color: Colors.black);
              }),
              const SizedBox(height: 20),
              Obx(() {
                return buildTextFun(context,
                    title: "${loginController.mobileNumber.value}",
                    fontsize: 18,
                    fontweight: FontWeight.bold,
                    color: Colors.black);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
