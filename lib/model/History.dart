// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'History.g.dart';

@HiveType(typeId: 0)
class History extends HiveObject {
  @HiveField(0)
  String model;

  @HiveField(1)
  String year;

  @HiveField(2)
  String transmission;

  @HiveField(3)
  double mileage;

  @HiveField(4)
  String fuelType;

  @HiveField(5)
  double tax;

  @HiveField(6)
  double mpg;

  @HiveField(7)
  double engineSize;

  @HiveField(8)
  String prediction;

  History({
    required this.model,
    required this.year,
    required this.transmission,
    required this.mileage,
    required this.fuelType,
    required this.tax,
    required this.mpg,
    required this.engineSize,
    required this.prediction,
  });
}
