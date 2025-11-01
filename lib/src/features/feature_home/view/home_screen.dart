import 'package:finacial_manager/src/features/feature_home/controller/home_screen_controller.dart';
import 'package:finacial_manager/src/features/feature_home/domain/entities/money.dart';
import 'package:finacial_manager/src/features/feature_home/widget/empty_widget.dart';
import 'package:finacial_manager/src/features/feature_home/widget/header_widget.dart';
import 'package:finacial_manager/src/features/feature_new_transaction/view/add_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../data/constant.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      initState: (state) {
        Get.lazyPut(() => HomeScreenController());
      },
      builder: (controller) {
        return Container(
          width: 360.w,
          height: 690.h,
          child: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: HeaderWidget()),
                SliverList.builder(
                  itemCount: controller.money.length == 0
                      ? 1
                      : controller.money.length,
                  itemBuilder: (context, index) {
                    if (controller.money.isEmpty) return EmptyWidget();
                    Money money = controller.money[index];
                    return GestureDetector(
                      onTap: () {
                        controller.isEditing = true;
                        Get.to(AddTransaction(),arguments: money);
                      },
                      onLongPress: () {
                        customDialog(context: context, title: 'Are you sure about delete ${money.title}', onYesPressed: () {
                          controller.money.removeAt(index);
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
                                color: money.isReceived
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              child: Icon(
                                money.isReceived
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
                                money.title,
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
                                  money.getPriceDolor,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 19.sp,
                                    color: Colors.black87,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                Text(
                                  money.date,
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
