import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jk_event/controller/login_controller.dart';
import 'package:jk_event/utils/constants.dart';
import 'package:jk_event/utils/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../router/routers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LoginController loginController = Get.put(LoginController());
  bool _isCustomerDetailsVisible = false; // Track visibility of the container

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
          backgroundColor: Colors.yellowAccent,
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
              // Show the customer details container if visible
              if (_isCustomerDetailsVisible)
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTextFun(context,
                          title: "Customer Details",
                          fontsize: 22,
                          fontweight: FontWeight.bold,
                          color: Colors.black),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Mobile Number',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Purpose of donation',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Donate',
                          prefixIcon: Icon(Icons.currency_rupee),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        maxLines: 2,
                        decoration: InputDecoration(
                          hintText: 'Address',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Your submit logic here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.blue, // Sets the button color to blue
                          ),
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _isCustomerDetailsVisible = !_isCustomerDetailsVisible;
            });
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.blue, // You can change the color here
        ),
      ),
    );
  }
}
