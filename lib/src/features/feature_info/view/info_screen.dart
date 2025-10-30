import 'package:finacial_manager/src/features/feature_info/widget/info_widget_en.dart';
import 'package:finacial_manager/src/features/feature_info/widget/info_widget_fa.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InfoScreen extends StatefulWidget {
  // final double paidToday;
  // final double paidThisMonth;
  // final double paidThisYear;
  // InfoScreen({required this.paidToday, required this.paidThisMonth, required this.paidThisYear});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Column(
        children: [
          if (Get.locale?.toString() == 'en_US') ...[
            InfoWidgetEN(receivedDay: '10', receivedMonth: '400', receivedYear: '1000', paidDay: '10', paidMonth: '20', paidYear: '30',),
          ] else if (Get.locale?.toString() == 'fa_IR') ...[
            InfoWidgetFA(),
          ],
        ],
      ),
    );
  }
}
