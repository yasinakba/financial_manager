import 'package:hive/hive.dart';

part 'money.g.dart';

@HiveType(typeId: 1)
class Money extends HiveObject {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? price;
  @HiveField(2)
  String? date;
  @HiveField(3)
  bool? isReceived;

  Money(this.title, this.price, this.date, this.isReceived);
}
