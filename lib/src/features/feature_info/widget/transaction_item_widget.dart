import 'package:finacial_manager/src/features/feature_home/controller/home_screen_controller.dart';
import 'package:finacial_manager/src/features/feature_home/data/constant.dart';
import 'package:finacial_manager/src/features/feature_home/domain/entities/money.dart';
import 'package:finacial_manager/src/features/feature_new_transaction/view/add_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class TransactionItemWidget extends StatelessWidget {
  final Money money;
  final String id;
  TransactionItemWidget({required this.money, required this.id});

  String formatPrice(String price) {
    if (price.isEmpty) return '0';
    // Remove any existing non-digits just in case (except maybe decimal point if needed, but assuming integer based on "every 3 zeros")
    String cleanPrice = price.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanPrice.isEmpty) return '0';
    
    // Reverse, add commas, reverse back
    // Or use RegExp
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    Function mathFunc = (Match match) => '${match[1]},';
    return cleanPrice.replaceAllMapped(reg, mathFunc as String Function(Match));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return GestureDetector(
        onTap: () {
          controller.isEditing = true;
          controller.index = id;
          Get.find<HomeController>().titleController.text = money.title??'';
          Get.find<HomeController>().priceController.text = money.price??'';
          Get.find<HomeController>().selectedValue = money.isReceived ?? false ? 1 : 0;
          Get.find<HomeController>().date = money.date??'';
          Get.to(AddTransaction(), arguments: money);
        },
        onLongPress: () {
          customDialog(
              context: context, title: money.title ?? '', onYesPressed: () async {
            
            await money.delete();

            Get.back();
            controller.update();
          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.08),
                offset: Offset(0, 4),
                blurRadius: 12,
                spreadRadius: 0,
              ),
            ],
          ),
          padding: EdgeInsets.all(12.w),
          child: Row(
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (money.isReceived ?? false ? Colors.green : Colors.red).withOpacity(0.1),
                ),
                child: Icon(
                  money.isReceived ?? false
                      ? IconsaxPlusBold.add_square
                      : IconsaxPlusBold.minus_square,
                  color: money.isReceived ?? false ? Colors.green : Colors.red,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      money.title ?? 'Unknown',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      money.date ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    (money.isReceived ?? false ? '+' : '-') + formatPrice(money.price ?? '0'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: money.isReceived ?? false ? Colors.green : Colors.red,
                      fontFamily: 'Roboto',
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
