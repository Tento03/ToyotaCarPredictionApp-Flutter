// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'History.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoryAdapter extends TypeAdapter<History> {
  @override
  final int typeId = 0;

  @override
  History read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return History(
      model: fields[0] as String,
      year: fields[1] as String,
      transmission: fields[2] as String,
      mileage: fields[3] as double,
      fuelType: fields[4] as String,
      tax: fields[5] as double,
      mpg: fields[6] as double,
      engineSize: fields[7] as double,
      prediction: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, History obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.model)
      ..writeByte(1)
      ..write(obj.year)
      ..writeByte(2)
      ..write(obj.transmission)
      ..writeByte(3)
      ..write(obj.mileage)
      ..writeByte(4)
      ..write(obj.fuelType)
      ..writeByte(5)
      ..write(obj.tax)
      ..writeByte(6)
      ..write(obj.mpg)
      ..writeByte(7)
      ..write(obj.engineSize)
      ..writeByte(8)
      ..write(obj.prediction);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
