import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User{
  @HiveField(0)
  String? firstName;
  @HiveField(1)
  String? lastName;
  @HiveField(2)
  String? address;
  @HiveField(3)
  String? city;
  @HiveField(4)
  int? age;
  User({required this.firstName,required this.age,required this.lastName,required this.address ,required this.city});
}