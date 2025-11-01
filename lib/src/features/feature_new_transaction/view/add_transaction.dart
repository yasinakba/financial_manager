import 'dart:math';

import 'package:finacial_manager/src/features/feature_home/controller/home_screen_controller.dart';
import 'package:finacial_manager/src/features/feature_home/domain/entities/money.dart';
import 'package:finacial_manager/src/features/feature_new_transaction/widget/my_button.dart';
import 'package:finacial_manager/src/features/feature_new_transaction/widget/text_filed_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../widget/radio_button_widget.dart';

class AddTransaction extends StatelessWidget {
  Money money = Money(id: 0, title: 'title', price: 'price', date: 'date', isReceived: true);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(initState: (state) {
      Get.lazyPut(() => HomeScreenController(),);
      var controller = Get.find<HomeScreenController>();
      if(controller.isEditing){
        if(Get.arguments != null){
         money = Get.arguments;
          controller.titleController.text = money.title;
          controller.priceController.text = money.price;
        }
      }
    },builder: (controller) {

      return Scaffold(
        body: SafeArea(
          child: Container(
            width: 360.w,
            height: 690.h,
            child: Column(
              children: [
                Text(controller.isEditing? 'Edit transaction'.tr :'New transection'.tr, style: TextStyle(fontSize: 17.sp),),
                SizedBox(height: 10.h,),
                TextFiledWidget(controller: controller.titleController,
                  hint: 'title',
                  type: TextInputType.text,
                  icon: IconsaxPlusBold.document_text,),
                TextFiledWidget(controller: controller.priceController,
                  hint: 'price',
                  type: TextInputType.number,
                  icon: IconsaxPlusBold.moneys,),
                OutlinedButton(onPressed: () {}, child: Text('DateTime'.tr)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RadioButtonWidget(value: 0,
                      groupValue: controller.selectedValue,
                      title: 'paid'.tr,
                      onChanged: (int value) {
                          controller.selectedValue = value;
                          controller.update();
                      },),
                    RadioButtonWidget(value: 1,
                      groupValue: controller.selectedValue,
                      title: 'receive'.tr,
                      onChanged: (int value) {
                          controller.selectedValue = value;
                          controller.update();
                      },),
                  ],
                ),
                MyButton(title: controller.isEditing?'Edit': 'Add', onTap: () {
                  controller.isEditing = false;
                  Get.back();
                  var m = Money(id: Random().nextInt(9999),
                      title: controller.titleController.text,
                      price: controller.priceController.text,
                      date: '2025/8/21',
                      isReceived: controller.selectedValue == 0 ? false : true);
                  if(!controller.isEditing){
                  controller.moneyBox.add(m);
                  }else
                  {
                    controller.moneyBox.put(m.id, m);
                  }
                  controller.titleController.clear();
                  controller.priceController.clear();
                  controller.selectedValue = -1;
                  controller.update();
                },),
              ],
            ),
          ),
        ),
      );
    });
  }
}
