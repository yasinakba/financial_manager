
import 'package:finacial_manager/src/features/feature_home/domain/entities/money.dart';

import 'package:hive/hive.dart';
    String year = DateTime.now().year.toString();
    String month = DateTime.now().month.toString();
    String day = DateTime.now().day.toString();
    Box<Money>? hiveBox =  Hive.box<Money>('moneyBox');
class Calculate{
 static String today(){
    return '$year/$month/$day';
  }


  static double paidToday(){
   double result = 0;
    for(var value in hiveBox!.values){
      if(value.date == today() && value.isReceived == false){
       return result += double.parse(value.price ??'');
      }
    }
    return 0;
  }
  static double receiveToday(){
   double result = 0;
    for(var value in hiveBox!.values){
      if(value.date == today() && value.isReceived == true){
       return result += double.parse(value.price??'');
      }
    }
    return 0;
  }
 static double paidMonth(){
   double result = 0;
   for(var value in hiveBox!.values){
     if(value.date!.substring(5,7) == month && value.isReceived == false){
       return result += double.parse(value.price??'');
     }
   }
   return 0;
 }
 static double receiveMonth(){
   double result = 0;
   for(var value in hiveBox!.values){
     if(value.date!.substring(5,7) == month && value.isReceived == true){
       return result += double.parse(value.price??'');
     }
   }
   return 0;
 }
 static double paidYear(){
   double result = 0;
   for(var value in hiveBox!.values){
     if(value.date!.substring(0,4) == year && value.isReceived == false){
       return result += double.parse(value.price??'');
     }
   }
   return 0;
 }
 static double receiveYear(){
   double result = 0;
   for(var value in hiveBox!.values){
     if(value.date!.substring(0,4) == year && value.isReceived == true){
       return result += double.parse(value.price??'');
     }
   }
   return 0;
 }
}