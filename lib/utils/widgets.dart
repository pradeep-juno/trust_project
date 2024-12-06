import 'package:flutter/material.dart';

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
