import 'package:finacial_manager/src/features/feature_home/domain/entities/money.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class HomeScreenController extends GetxController{

   @override
  void onInit() {
      super.onInit();
      money.clear();
      moneyBox.values.forEach((element) {
        money.add(element);
      },);

  }

   bool isEditing = false;
   List<Money> money = [];
   TextEditingController titleController = TextEditingController();
   TextEditingController priceController = TextEditingController();
   bool focus = false;
   int selectedValue = 0;
   final Box<Money> moneyBox = Hive.box<Money>('moneyBox');
}