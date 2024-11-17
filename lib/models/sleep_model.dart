import 'package:isar/isar.dart';

part 'sleep_model.g.dart';

@collection
class SleepModel {
  Id id = Isar.autoIncrement;

  String? day;
  double? hours;
  SleepModel({this.day, this.hours});
}
