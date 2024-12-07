import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jk_event/utils/constants.dart';
import 'package:jk_event/utils/functions.dart';

import '../controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      loginController.goToHomeScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: buildCircleAvatar(radius: 50, imagePath: AppConstant.jkImage
                // Replace with your image path
                ),
          ),
          buildSizedBoxHeightFun(context, height: 60.0),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextFun(context,
                    title: AppConstant.userId,
                    fontsize: 20,
                    fontweight: FontWeight.bold,
                    color: Colors.black),
                buildSizedBoxHeightFun(context, height: 5),
                buildTextFormFieldFun(
                  context,
                  hint: AppConstant.mobileNo,
                  controller: loginController.mobileController,
                  color: Colors.pinkAccent,
                  icon: Icons.person,
                  isPassword: false,
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  maxLines: 1,
                ),
                buildSizedBoxHeightFun(context, height: 10),
                buildTextFun(context,
                    title: AppConstant.password,
                    fontsize: 20,
                    fontweight: FontWeight.bold,
                    color: Colors.black),
                buildSizedBoxHeightFun(context, height: 5),
                buildTextFormFieldFun(context,
                    hint: AppConstant.enterPassword,
                    controller: loginController.passwordController,
                    color: Colors.pinkAccent,
                    icon: Icons.lock,
                    isPassword: true,
                    keyboardType: TextInputType.text,
                    inputFormatters: [LengthLimitingTextInputFormatter(8)]),
                buildSizedBoxHeightFun(context, height: 15),
                buildContainerButtonFun(context, AppConstant.login,
                    color: Colors.pinkAccent,
                    onPressed: () => loginController.submit(context)),
              ],
            ),
          )
        ],
      )),
    );
  }
}
