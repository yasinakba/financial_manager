import 'package:flutter/material.dart';
import 'package:get/get.dart';

const kPurpleColor = Color(0xFF6C63FF);
const kRedColor = Color(0xFFFF2D55);
const kGreenColor = Color(0xFF00C89C);

void customDialog({required BuildContext context, required String title,required VoidCallback onYesPressed})async{
  showDialog(
  context: context,
  builder: (context) => AlertDialog(
  title: Text(title),
  actions: [
  TextButton(onPressed:onYesPressed, child: Text('Yes'.tr)),
  TextButton(onPressed: () {
    Get.back();
  }, child: Text('No'.tr)),
  ],
  ));
}