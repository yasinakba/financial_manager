// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoneyAdapter extends TypeAdapter<Money> {
  @override
  final int typeId = 1;

  @override
  Money read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Money(
      id: fields[1] as int,
      title: fields[2] as String,
      price: fields[4] as String,
      date: fields[5] as String,
      isReceived: fields[6] as bool,
    ).._price = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, Money obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj._price)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.date)
      ..writeByte(6)
      ..write(obj.isReceived);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoneyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
