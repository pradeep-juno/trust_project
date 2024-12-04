import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jk_event/utils/constants.dart';

class LoginController extends GetxController {
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

      print("Admin MobileNumber : \$storedMobileNumber");
      print("Admin Password : \$storedPassword");

      if (mobileNumber == storedMobileNumber && password == storedPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Admin Login Successfully'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.blue,
            behavior: SnackBarBehavior.floating,
          ),
        );

        clearController(context);
        // Get.offNamed(AppRouter.LOGIN_SCREEN);
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
}
