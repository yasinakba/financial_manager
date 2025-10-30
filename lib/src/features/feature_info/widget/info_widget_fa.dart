import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InfoWidgetFA extends StatelessWidget {
  const InfoWidgetFA({super.key});

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
          buildWrap('Received today:'.tr, '0', 'Paid today:'.tr, '0'),
          buildWrap('Received this month:'.tr, '0', 'Paid this month:'.tr, '0'),
          buildWrap('Received this year:'.tr, '0', 'Paid this year:'.tr, '0'),
        ],
      ),
    );
  }
}
