import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jk_event/utils/constants.dart';
import 'package:jk_event/utils/functions.dart';

import '../controller/login_controller.dart';

class DesktopLoginScreen extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  DesktopLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircleAvatar(
              radius: 50,
              child: Image.asset(AppConstant.logoImage, fit: BoxFit.cover),
            ),
          ),
          buildSizedBoxHeightFun(context, height: 80.0),
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
                buildTextFormFieldFun(context,
                    hint: AppConstant.mobileNo,
                    controller: loginController.mobileController,
                    color: Colors.grey,
                    icon: Icons.person,
                    isPassword: false,
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10)
                    ]),
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
                    color: Colors.grey,
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

/*
   buildContainerButton(context,
                          title: ProjectConstants.login,
                          titleColor: ProjectColors.whiteColor,
                          backgroundColor: ProjectColors.accentPink,
                          borderCircular: 8.0,
                          onPressed: () => loginController.submit(context),
                          buttonHeight: 50.0,
                          width: MediaQuery.of(context).size.width),

                          onPressed: () => loginController.submit(context),
 */
