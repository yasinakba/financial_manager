import 'package:finacial_manager/src/features/feature_home/controller/home_screen_controller.dart';
import 'package:finacial_manager/src/features/feature_home/domain/entities/money.dart';
import 'package:finacial_manager/src/features/feature_home/widget/empty_widget.dart';
import 'package:finacial_manager/src/features/feature_home/widget/header_widget.dart';
import 'package:finacial_manager/src/features/feature_info/widget/transaction_item_widget.dart';
import 'package:finacial_manager/src/features/feature_new_transaction/view/add_transaction.dart';
import 'package:finacial_manager/src/features/feature_new_transaction/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      initState: (state) {
        Get.lazyPut(() => HomeController());
      },
      builder: (controller) {
        return Container(
          width: 360.w,
          height: 690.h,
          child: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: HeaderWidget()),
                SliverToBoxAdapter(
                  child: FutureBuilder(future: Future(() => Hive.openLazyBox('moneyBox')), builder: (context, snapshot) {
                    if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
                      return controller.showData();
                    }else{
                      return EmptyWidget();
                    }
                  },),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

