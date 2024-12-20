import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jk_event/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../router/routers.dart';

class LoginController extends GetxController {
  var mobileNumber = ''.obs;
  var password = ''.obs;
  var adminName = ''.obs;
  var adminId = ''.obs;

  late Stream<DocumentSnapshot> adminDataStream;

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final mobileController = TextEditingController();
  final passwordController = TextEditingController();

  submit(BuildContext context) async {
    if (await validateFields(context)) {
      String mobileNumber = mobileController.text.trim().toString();
      String password = passwordController.text.trim().toString();

      try {
        await isCheckAdminData(context, mobileNumber, password);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.blue,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<bool> validateFields(BuildContext context) async {
    String mobileNumber = mobileController.text.trim();
    String password = passwordController.text.trim();

    if (mobileNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Provide Mobile Number'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.blue,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return false;
    }
    if (mobileNumber.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mobile Number must be 10 digits'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.blue,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return false;
    }

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Provide Password'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.blue,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return false;
    }
    if (password.length < 4) {
      // Password too short
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password length must be at least 4'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.blue,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return false;
    }
    if (password.length >= 4 && password.length < 8) {
      // Password length is between 4 and 7 characters
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password length must be exactly 8'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.blue,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return false;
    }
    return true;
  }

  Future<bool> isCheckAdminData(
    BuildContext context,
    String mobileNumber,
    String password,
  ) async {
    DocumentSnapshot adminSnapshot = await FirebaseFirestore.instance
        .collection(AppConstant.collectionAdmin)
        .doc(AppConstant.adminId)
        .get();

    if (adminSnapshot.exists) {
      String storedMobileNumber = adminSnapshot['mobile no'];
      String storedPassword = adminSnapshot['password'];

      print("Admin MobileNumber : $storedMobileNumber");
      print("Admin Password : $storedPassword");

      if (mobileNumber == storedMobileNumber && password == storedPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Admin Login Successfully'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.blue,
            behavior: SnackBarBehavior.floating,
          ),
        );
        //locally stored
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('mobile', mobileNumber);
        await prefs.setString('password', password);
        await prefs.setString('id', AppConstant.adminId);

        getAdminDataFromPreferences();

        clearController(context);

        Get.offNamed(AppRouter.HOME_SCREEN);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid Credentials'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.blue,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
    return false;
  }

  void clearController(BuildContext context) {
    mobileController.clear();
    passwordController.clear();
  }

  void listenAdminDataUpdates(BuildContext context, String id) {
    try {
      adminDataStream = firebaseFirestore
          .collection(AppConstant.collectionAdmin)
          .doc(id)
          .snapshots();

      adminDataStream.listen((documentSnapshots) {
        if (documentSnapshots.exists) {
          mobileNumber.value = documentSnapshots['mobile no'] ?? 'Not Found';
          password.value = documentSnapshots['password'] ?? 'Not Found';
          adminName.value = documentSnapshots['name'] ?? 'Not Found';
          adminId.value = documentSnapshots['id'] ?? 'Not Found';

          print('Admin Mobile Number: ${mobileNumber.value}');
          print('Admin Password: ${password.value}');
          print('Admin Name: ${adminName.value}');
          print('Admin ID: ${adminId.value}');
        } else {
          print("ID not fournd");
        }
      });
    } catch (e) {
      print("timeout ");
    }
  }

  goToHomeScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('id');

    if (id!.isNotEmpty) {
      Get.offNamed(AppRouter.HOME_SCREEN);
    }
  }
}

Future<void> getAdminDataFromPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? mobileNumber = prefs.getString('mobile');
  String? password = prefs.getString('password');

  // Print retrieved data with newlines
  print(
      "Retrieved Admin Data:\nMobile Number: $mobileNumber\nPassword: $password");
}
