import 'package:hive/hive.dart';

part 'main_model.g.dart';

@HiveType(typeId: 0)
class MainModel{
  @HiveField(0)
  DateTime dateTime;
  @HiveField(1)
  double progress = 0;
  @HiveField(2)
  int type;
  @HiveField(3)
  int number = 0;
  MainModel({required this.dateTime, required this.type});
}