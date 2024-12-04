import 'package:flutter/material.dart';

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

buildTextFormFieldFun(BuildContext context,
    {required String hint,
    required TextEditingController controller,
    required Color color,
    required IconData icon}) {
  return Padding(
    padding: const EdgeInsets.only(right: 16),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide:
              BorderSide(color: Colors.grey), // Grey border when not focused
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide:
              BorderSide(color: Colors.grey), // Grey border when focused
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.pinkAccent,
        ),
      ),
    ),
  );
}
