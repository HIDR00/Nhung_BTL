import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

import '../controller/setting_state.dart';

class WaterDialog extends StatefulWidget {
  const WaterDialog({super.key});

  @override
  State<WaterDialog> createState() => _WaterDialogState();
}

class _WaterDialogState extends State<WaterDialog> {
  late DatabaseReference _alermWater;
  late DatabaseReference _volumeWater;
  late DatabaseReference _alermFood;
  late DatabaseReference _volumeFood;
  int dropdownValue = 100;

  final Time _time = Time(hour: 11, minute: 30);

  @override
  void initState() {
    super.initState();
    _alermWater = FirebaseDatabase.instance.ref().child('ESP/SETTIMEWATER');
    _volumeWater = FirebaseDatabase.instance.ref().child('ESP/VOLUME');
    _alermFood = FirebaseDatabase.instance.ref().child('ESP/SETTIMEFOOD');
    _volumeFood = FirebaseDatabase.instance.ref().child('ESP/MASS');
  }

  void choose() {
    if (context.read<settingState>().type) {
      _volumeFood.set(dropdownValue);
      context.read<settingState>().updateVolumeFood(dropdownValue.toString());
    } else {
      _volumeWater.set(dropdownValue);
      context.read<settingState>().updateVolumeWater(dropdownValue.toString());
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.read<settingState>().type
          ? 'Cài đặt thời gian ăn'
          : 'Cài đặt thời gian uống'),
      content: SizedBox(
        height: 200,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () async {
                      Navigator.of(context).push(
                        showPicker(
                          showSecondSelector: false,
                          is24HrFormat: true,
                          context: context,
                          value: _time,
                          onChange: (value) {
                            if (context.read<settingState>().type) {
                              _alermFood.set("${value.hour}:${value.minute}");
                              context.read<settingState>().updateTimeFood(
                                  "${value.hour}:${value.minute}");
                            } else {
                              _alermWater.set("${value.hour}:${value.minute}");
                              context.read<settingState>().updateTimeWater(
                                  "${value.hour}:${value.minute}");
                            }
                          },
                          onChangeDateTime: (DateTime dateTime) {
                            debugPrint("[debug datetime]:  $dateTime");
                          },
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.access_time,
                      size: 30,
                    )),
                NumberPicker(
                    value: dropdownValue,
                    minValue: 100,
                    maxValue: 400,
                    step: 100,
                    onChanged: (value) {
                      setState(() {
                        dropdownValue = value;
                      });
                    },
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.black),
                        bottom: BorderSide(color: Colors.black),
                      ),
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.red)),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Thoát',
                      style: TextStyle(color: Colors.white),
                    )),
                ElevatedButton(
                  onPressed: () async {
                    choose();
                  },
                  child: const Text('Lưu'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
