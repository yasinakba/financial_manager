import 'package:finacial_manager/src/features/feature_home/controller/home_screen_controller.dart';
import 'package:finacial_manager/src/features/feature_home/data/constant.dart';
import 'package:finacial_manager/src/features/feature_home/domain/entities/money.dart';
import 'package:finacial_manager/src/features/feature_new_transaction/view/add_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class TransactionItemWidget extends StatelessWidget {
  final Money money;
  final String id;
  TransactionItemWidget({required this.money, required this.id});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return GestureDetector(
        onTap: () {
          controller.isEditing = true;
          controller.index = id;
          Get.find<HomeController>().titleController.clear();
          Get.find<HomeController>().priceController.clear();
          Get.to(AddTransaction(), arguments: money);
        },
        onLongPress: () {
          customDialog(
              context: context, title: money.title ?? '', onYesPressed: () {
            // controller.hiveBox!.deleteAt(index);

            Get.back();
            controller.update();
          });
        },
        child: Container(
          alignment: AlignmentDirectional.centerStart,
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          width: 358.w,
          height: 70.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsetsDirectional.only(end: 5.w),
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: money.isReceived ?? false
                      ? Colors.green
                      : Colors.red,
                ),
                child: Icon(
                  money.isReceived ?? false
                      ? IconsaxPlusBold.add_square
                      : IconsaxPlusBold.minus_square,
                  color: Colors.white,
                  size: 25.sp,
                ),
              ),
              SizedBox(
                width: 150.w,
                child: Text(
                  textAlign: TextAlign.center,
                  money.title??'',
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13.sp,
                    color: Colors.black87,
                  ),
                ),
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    money.price??'0',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 19.sp,
                      color: Colors.black87,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  Text(
                    money.date ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15.sp,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
