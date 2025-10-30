import 'package:finacial_manager/src/features/feature_new_transaction/widget/my_button.dart';
import 'package:finacial_manager/src/features/feature_new_transaction/widget/text_filed_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../widget/radio_button_widget.dart';

class AddTransaction extends StatefulWidget {

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  bool focus = false;
  int selectedValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: 360.w,
          height: 690.h,
          child: Column(
            children: [
              Text('New transection'.tr,style: TextStyle(fontSize: 17.sp),),
              SizedBox(height: 10.h,),
              TextFiledWidget(controller: descController, hint: 'descriptions', type: TextInputType.text, icon: IconsaxPlusBold.document_text,),
              TextFiledWidget(controller: priceController, hint: 'price',type: TextInputType.number,icon: IconsaxPlusBold.moneys,),
              OutlinedButton(onPressed: () {}, child: Text('DateTime'.tr)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RadioButtonWidget(value: 0, groupValue: selectedValue, title: 'paid'.tr, onChanged: (int value) {
                    setState(() {
                    selectedValue = value;
                    });
                  },),
                  RadioButtonWidget(value: 1, groupValue: selectedValue, title: 'receive'.tr, onChanged: (int value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },),
                ],
              ),
              MyButton(title: 'Add'),
            ],
          ),
        ),
      ),
    );
  }
}
