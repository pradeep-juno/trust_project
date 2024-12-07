import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  String? hint,
  TextEditingController? controller,
  Color? color,
  IconData? icon,
  required bool isPassword,
  TextInputType? keyboardType,
  List<TextInputFormatter>? inputFormatters,
  int maxLines = 1,
  bool? border,
  double? height,
}) {
  bool obscureText = isPassword;

  return StatefulBuilder(
    builder: (context, setState) {
      return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: border == true
                ? BorderRadius.circular(2.0)
                : BorderRadius.circular(10.0)),
        //height: maxLines == 1 ? 50 : height,
        child: Padding(
          padding: const EdgeInsets.only(right: 10, top: 4),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
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
            maxLines: maxLines,
          ),
        ),
      );
    },
  );
}

buildContainerButtonFun(BuildContext context, String title,
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
                title: title,
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
