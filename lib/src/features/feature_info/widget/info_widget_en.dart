import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InfoWidgetEN extends StatelessWidget {
   String receivedDay = "0";
   String receivedMonth= "0";
   String receivedYear = "0";
   String paidDay = "0";
   String paidMonth= "0";
   String paidYear = "0";
  InfoWidgetEN({required this.receivedDay, required this.receivedMonth, required this.receivedYear,required this.paidDay,required this.paidMonth,required this.paidYear,});

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
    TextStyle valueStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

    Widget buildWrap(String label1, String value1, String label2, String value2) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Wrap(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(label2, style: labelStyle),
                  SizedBox(width: 2.w,),
                  Text('$value2 ', style: valueStyle),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(label1, style: labelStyle),
                  SizedBox(width: 2.w,),
                  Text('$value1 ', style: valueStyle),
                ],
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Transaction Management (\$)'.tr,
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          buildWrap('Received today:'.tr, receivedDay, 'Paid today:'.tr, paidDay),
          buildWrap('Received this month:'.tr, receivedMonth, 'Paid this month:'.tr, paidMonth),
          buildWrap('Received this year:'.tr, receivedYear, 'Paid this year:'.tr, paidYear),
        ],
      ),
    );
  }
}
