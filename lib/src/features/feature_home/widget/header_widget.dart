import 'package:finacial_manager/src/features/feature_home/controller/home_screen_controller.dart';
import 'package:finacial_manager/src/features/feature_home/domain/entities/money.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class HeaderWidget extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Container(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 4.w),
          width: 360.w,
          height: 50.h,
          child: Row(
            children: [
              Expanded(
                child: SearchBarAnimation(
                  textAlignToRight: false,
                  textEditingController: controller.searchController,
                  isOriginalAnimation: true,
                  trailingWidget: Icon(IconsaxPlusBold.search_normal),
                  secondaryButtonWidget: Icon(IconsaxPlusBold.close_square),
                  onChanged: (String text) {
                    if (text.isEmpty) {
                      controller.money
                        ..clear()
                        ..addAll(controller.hiveBox!.values);
                      controller.isSearch = false;
                    } else {
                      final result = controller.hiveBox!.values.where((value) {
                        return value.title?.toLowerCase().contains(text.toLowerCase()) ?? false ||
                            value.date!.toLowerCase().contains(text.toLowerCase()) ;
                      }).toList();

                      controller.money
                        ..clear()
                        ..addAll(result);
                      controller.isSearch = true;
                    }
                    controller.update();
                  },
                  onFieldSubmitted: (String text) {
                    final result = controller.hiveBox!.values.where((value) {
                      return value.title?.contains(text.toLowerCase()) ?? false || value.date!.toLowerCase().contains(text.toLowerCase());}).toList();
                    controller.money
                      ..clear()
                      ..addAll(result);
                    controller.isSearch = true;
                    controller.update();
                  },
                  buttonWidget: Icon(
                    IconsaxPlusBold.search_normal,
                    color: Colors.black,
                  ),
                  hintText: 'seek...'.tr,
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                'Transactions'.tr,
                style: TextStyle(fontSize: 13.sp, fontFamily: 'roph'),
              ),
            ],
          ),
        );
      },
    );
  }
}
