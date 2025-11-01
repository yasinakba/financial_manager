
import 'package:hive/hive.dart';
part 'money.g.dart';
@HiveType(typeId: 1)
class Money{
  @HiveField(1)
  int id;
  @HiveField(2)
  String title;
  @HiveField(3)
  String _price;
  @HiveField(4)
  String price;
  @HiveField(5)
  String date;
  @HiveField(6)
  bool isReceived;
  String get getPriceDolor => '\$ $_price';
  set setPrice (String value){
    assert (value.isNotEmpty,'Price cannot be null');
    _price = value;
  }
   Money({ required this.id, required this.title,required this.price,required this.date, required this.isReceived,}) : _price = price;
}

