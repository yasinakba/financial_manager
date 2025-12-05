import 'package:finacial_manager/src/core/localization/Translation.dart';
import 'package:finacial_manager/src/features/feature_home/domain/entities/money.dart';
import 'package:finacial_manager/src/features/feature_home/view/nave_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MoneyAdapter());
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        ScreenUtil.init(context);
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          translations: Translation(),
          locale: const Locale('en', 'US'),
          fallbackLocale: const Locale('fa', 'IR'),
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: 'roph',
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: NaveScreen(),
        );
      },
      designSize: Size(360, 690),
    );
  }
}
