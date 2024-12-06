import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

buildTextFun(BuildContext context,
    {required String title,
    required double fontsize,
    required FontWeight fontweight,
    required Color color}) {
  return Text(
    title,
    style: TextStyle(fontSize: fontsize, fontWeight: fontweight, color: color),
  );
}

buildSizedBoxHeightFun(BuildContext context, {required double height}) {
  return SizedBox(
    height: height,
  );
}

buildSizedBoxWidthFun(BuildContext context, {required double width}) {
  return SizedBox(
    width: width,
  );
}

buildTextFormFieldFun(
  BuildContext context, {
  required String hint,
  required TextEditingController controller,
  required Color color,
  required IconData icon,
  required bool isPassword,
  required TextInputType keyboardType,
  required List<TextInputFormatter> inputFormatters,
}) {
  bool obscureText = isPassword;

  return StatefulBuilder(
    builder: (context, setState) {
      return Padding(
        padding: const EdgeInsets.only(right: 16),
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                  color: Colors.grey), // Grey border when not focused
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide:
                  BorderSide(color: Colors.grey), // Grey border when focused
            ),
            prefixIcon: Icon(
              icon,
              color: color,
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  )
                : null,
          ),
        ),
      );
    },
  );
}

buildContainerButtonFun(BuildContext context, String login,
    {required Color color, required Function() onPressed}) {
  return InkWell(
      onTap: onPressed,
      child: Container(
          height: 44,
          width: 298,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: color),
          child: Center(
            child: buildTextFun(context,
                title: AppConstant.login,
                fontsize: 12,
                fontweight: FontWeight.w800,
                color: Colors.white),
          )));
}

buildCircleAvatar({
  required double radius,
  String? imagePath,
  String? text,
  BoxFit fit = BoxFit.cover,
  Color? color,
  double? fontsize,
  FontWeight? fontweight,
  MaterialColor? backgroundColor,
}) {
  if (imagePath != null)
    return CircleAvatar(
      radius: radius,
      child: ClipOval(
        child: Image.asset(
          imagePath!,
          fit: fit,
        ),
      ),
    );
  else if (text != null)
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      child: Text(
        text,
        style:
            TextStyle(color: color, fontSize: fontsize, fontWeight: fontweight),
      ),
    );
}
