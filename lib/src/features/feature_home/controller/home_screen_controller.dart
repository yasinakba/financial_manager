import 'package:finacial_manager/src/features/feature_home/domain/entities/money.dart';
import 'package:finacial_manager/src/features/feature_home/widget/empty_widget.dart';
import 'package:finacial_manager/src/features/feature_info/widget/transaction_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class HomeController extends GetxController {
  final List<Money> money = [];
  bool isEditing = false;
  bool isSearch = false;

  Box<Money>? hiveBox;

  @override
  void onInit() {
    super.onInit();
    money.clear();
  }

  Widget showData() {
    Box hiveBox = Hive.box<Money>('moneyBox');
   return ValueListenableBuilder(
      valueListenable: hiveBox.listenable(),
      builder: (BuildContext context,Box box, Widget? child) {
        if(box.values.isEmpty){
          return EmptyWidget();
        }
        return ListView.builder(itemCount: hiveBox.length,itemBuilder: (context, index) {
          final Money money = box.getAt(index);
          return TransactionItemWidget(money: money, id: index.toString(),);
        },);
      },
    );
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  void initializeEditTransaction() {
    if (isEditing) {
      if (Get.arguments != null) {
        Money money = Get.arguments;
        titleController.text = money.title ?? '';
        priceController.text = money.price ?? '';
        selectedValue = money.isReceived ?? false ? 1 : 0;
        date = money.date ?? '';
      }
    }
  }

  TextEditingController searchController = TextEditingController();
  String index = '';
  bool focus = false;
  int selectedValue = 0;
  String date = 'Date';

  void addTransaction() async {
    if (isEditing) {
      // Get the existing money object passed via arguments
      Money money = Get.arguments as Money;

      // Update its fields
      money.title = titleController.text;
      money.price = priceController.text;
      money.date = date;
      money.isReceived = selectedValue == 1;

      // Save the changes (HiveObject method)
      money.save();
      
      isEditing = false;
    } else {
      if (titleController.text.isNotEmpty || priceController.text.isNotEmpty) {
        Money newMoney = Money(titleController.text,priceController.text,date,selectedValue == 1?true:false,);
        var box = await Hive.openBox<Money>('moneyBox');
        int r = await box.add(newMoney);
        print(r);
      }
    }
    // Clear inputs
    titleController.clear();
    priceController.clear();
    selectedValue = -1;
    date = 'Date';
    Get.back();
  }


  void onOutButton(context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2099),
    );
    if (pickedDate != null) {
      String month = pickedDate.month.toString().padLeft(2, '0');
      String day = pickedDate.day.toString().padLeft(2, '0');
      date = '${pickedDate.year}/$month/$day';
      update();
    }
  }
}
