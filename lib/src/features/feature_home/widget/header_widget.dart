import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class HeaderWidget extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 4.w),
      width: 360.w,
      height: 50.h,
      child: Row(
        children: [
          Expanded(child: SearchBarAnimation(
            textAlignToRight: false,
            textEditingController: searchController,
            isOriginalAnimation: true,
            trailingWidget:Icon(IconsaxPlusBold.search_normal),
            secondaryButtonWidget:Icon(IconsaxPlusBold.close_square),
            onFieldSubmitted: (String text){},
            buttonWidget:Icon(IconsaxPlusBold.search_normal,color: Colors.black,),
            hintText: 'seek...'.tr,)),
          SizedBox(width: 6.w,),
          Text('Transactions'.tr,style: TextStyle(fontSize: 13.sp,fontFamily: 'roph',),),
        ],
      ),
    );
  }
}
