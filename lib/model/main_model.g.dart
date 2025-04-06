// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MainModelAdapter extends TypeAdapter<MainModel> {
  @override
  final int typeId = 0;

  @override
  MainModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MainModel(
      dateTime: fields[0] as DateTime,
      type: fields[2] as int,
    )
      ..progress = fields[1] as double
      ..number = fields[3] as int;
  }

  @override
  void write(BinaryWriter writer, MainModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.dateTime)
      ..writeByte(1)
      ..write(obj.progress)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.number);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
