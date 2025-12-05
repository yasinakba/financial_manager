import 'dart:math';

import 'package:finacial_manager/src/features/feature_home/controller/home_screen_controller.dart';
import 'package:finacial_manager/src/features/feature_home/data/constant.dart';
import 'package:finacial_manager/src/features/feature_home/domain/entities/money.dart';
import 'package:finacial_manager/src/features/feature_new_transaction/widget/my_button.dart';
import 'package:finacial_manager/src/features/feature_new_transaction/widget/text_filed_widget_price.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../utils/thousands_formatter.dart';
import '../widget/radio_button_widget.dart';

class AddTransaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
       bool edit = controller.isEditing;
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Text(edit == true? 'Edit transaction'.tr : 'New transection'.tr, style:fontOnly ),
                SizedBox(height: 10.h),
                TextFiledWidget(
                  controller: controller.titleController,
                  hint: 'title',
                  type: TextInputType.text,
                  icon: IconsaxPlusBold.document_text,
                ),
                TextFiledWidget(
                  controller: controller.priceController,
                  hint: 'price',
                  type: TextInputType.number,
                  icon: IconsaxPlusBold.moneys,
                  inputFormatters: [
                    ThousandsFormatter(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: ()  {
                        controller.onOutButton(context);
                        },
                      child: Text(
                        controller.date == 'Date' ? 'DateTime'.tr : controller.date,
                      ),
                    ),
                    Column(
                      children: [
                        RadioButtonWidget(
                          value: 0,
                          groupValue: controller.selectedValue,
                          title: 'paid'.tr,
                          onChanged: (int value) {
                            controller.selectedValue = value;
                            controller.update();
                          },
                        ),
                        RadioButtonWidget(
                          value: 1,
                          groupValue: controller.selectedValue,
                          title: 'receive'.tr,
                          onChanged: (int value) {
                            controller.selectedValue = value;
                            controller.update();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                MyButton(
                  title: edit == true? 'Edit' : 'Add',
                  onTap: ()  {
                   controller.addTransaction();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
