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
    // Ensure hiveBox is available for filtered searches
    if (hiveBox == null && Hive.isBoxOpen('moneyBox')) {
      hiveBox = Hive.box<Money>('moneyBox');
    }

    if (isSearch) {
        if (money.isEmpty) {
          return EmptyWidget(); 
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: money.length,
          itemBuilder: (context, index) {
             final Money item = money[index];
             return TransactionItemWidget(money: item, id: item.key.toString());
          },
        );
    }

    Box box = Hive.box<Money>('moneyBox');
    return ValueListenableBuilder(
      valueListenable: box.listenable(),
      builder: (BuildContext context,Box box, Widget? child) {
        if(box.values.isEmpty){
          return EmptyWidget();
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: box.length,
          itemBuilder: (context, index) {
            final Money money = box.getAt(index);
            return TransactionItemWidget(money: money, id: index.toString(),);
          },
        );
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
    try {
      // Clean price string (remove commas)
      String cleanPrice = priceController.text.replaceAll(',', '');
      
      if (isEditing) {
        // --- EDIT MODE ---
        // Get the existing money object passed via arguments
        if (Get.arguments is Money) {
          Money money = Get.arguments as Money;

          // Update its fields
          money.title = titleController.text;
          money.price = cleanPrice; // Save without commas
          money.date = date;
          money.isReceived = selectedValue == 1;

          // Save the changes (HiveObject method)
          await money.save();
          isEditing = false;
        }
      } else {
        // --- ADD MODE ---
        if (titleController.text.isNotEmpty || priceController.text.isNotEmpty) {
          Money newMoney = Money(
            titleController.text,
            cleanPrice, // Save without commas
            date,
            selectedValue == 1 ? true : false,
          );

          // Ensure box is open before adding
          var box = await Hive.openBox<Money>('moneyBox');
          this.hiveBox = box; // update reference

          int r = await box.add(newMoney);
          print("Transaction added with key: $r");
        }
      }

      // Clear inputs only on success
      titleController.clear();
      priceController.clear();
      selectedValue = -1;
      date = 'Date';
      Get.back(); // Close the screen/dialog

    } catch (e) {
      // Handle any errors (e.g., Show a snackbar)
      print("Error adding/editing transaction: $e");
      Get.snackbar(
        "Error",
        "Something went wrong while saving the transaction.",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }


  void onOutButton(context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2099),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textTheme: ThemeData.light().textTheme,
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      String month = pickedDate.month.toString().padLeft(2, '0');
      String day = pickedDate.day.toString().padLeft(2, '0');
      date = '${pickedDate.year}/$month/$day';
      update();
    }
  }
}
