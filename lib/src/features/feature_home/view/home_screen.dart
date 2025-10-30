import 'package:finacial_manager/src/features/feature_home/widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.w,
      height: 690.h,
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
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
              ),
            ),
            // SliverToBoxAdapter(
            //   child: EmptyWidget(),
            // ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                width: 358.w,
                height: 60.h,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsetsDirectional.only(end: 5.w),
                      width: 50.w,height: 50.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.red,
                      ),
                      child: Icon(IconsaxPlusBold.minus_square,color: Colors.white,size: 25.sp,),),
                    Text('Gym',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15.sp,color: Colors.black87,),),
                    Spacer(),
                    Column(
                      children: [
                        Text('5\$',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15.sp,color: Colors.black87,),),
                        Text('25/8/2025',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15.sp,color: Colors.black87,),),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
