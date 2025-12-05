import 'package:finacial_manager/src/features/feature_home/controller/home_screen_controller.dart';
import 'package:finacial_manager/src/features/feature_home/domain/entities/money.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
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
                  onCollapseComplete: () {
                    controller.searchController.clear();
                    controller.isSearch = false;
                    controller.money.clear();
                    controller.update();
                  },
                  onChanged: (String text) {
                    if (text.isEmpty) {
                      controller.isSearch = false;
                      controller.money.clear();
                    } else {
                      controller.isSearch = true;
                      controller.money.clear();
                      
                      // Safely access the box
                      var values = controller.hiveBox?.values ?? Hive.box<Money>('moneyBox').values;

                      final result = values.where((value) {
                        return (value.title?.toLowerCase().contains(text.toLowerCase()) ?? false) ||
                               (value.date?.toLowerCase().contains(text.toLowerCase()) ?? false);
                      }).toList();

                      controller.money.addAll(result);
                    }
                    controller.update();
                  },
                  onFieldSubmitted: (String text) {
                    if (text.isEmpty) {
                       controller.isSearch = false;
                       controller.money.clear();
                    } else {
                       controller.isSearch = true;
                       controller.money.clear();
                       
                       var values = controller.hiveBox?.values ?? Hive.box<Money>('moneyBox').values;
                       
                       final result = values.where((value) {
                        return (value.title?.toLowerCase().contains(text.toLowerCase()) ?? false) ||
                               (value.date?.toLowerCase().contains(text.toLowerCase()) ?? false);
                       }).toList();
                       
                       controller.money.addAll(result);
                    }
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
