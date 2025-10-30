import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:finacial_manager/src/features/feature_home/view/home_screen.dart';
import 'package:finacial_manager/src/features/feature_info/view/info_screen.dart';
import 'package:finacial_manager/src/features/feature_new_transaction/view/add_transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class NaveScreen extends StatefulWidget {

  @override
  State<NaveScreen> createState() => _NaveScreenState();
}

class _NaveScreenState extends State<NaveScreen> {
  int index = 0;
  Widget body = HomeScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(backgroundColor: Colors.purple,onPressed: () {
          Get.to(AddTransaction(),transition: Transition.downToUp,curve: Curves.fastLinearToSlowEaseIn,duration: Duration(milliseconds: 300));
          Get.to(AddTransaction(),transition: Transition.downToUp,curve: Curves.fastLinearToSlowEaseIn,duration: Duration(milliseconds: 300));
        },child: Icon(IconsaxPlusBold.add,color: Colors.white,),),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        inactiveColor: Colors.black54,
      activeColor: Colors.black,
      icons: [IconsaxPlusBold.home_2,IconsaxPlusBold.info_circle],
      activeIndex: index,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.smoothEdge,
      leftCornerRadius: 32,
      rightCornerRadius: 32,
      onTap: (index){
          setState(() {
            this.index = index;
            if(this.index == 0){
              body = HomeScreen();
            }else if(this.index == 1){
              body = InfoScreen();
            }
          });
      }),
      body: body,
    );
  }
}

