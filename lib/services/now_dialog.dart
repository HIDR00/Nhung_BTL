import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

import '../controller/setting_state.dart';

class NowDialog extends StatefulWidget {
  const NowDialog({super.key, required this.index});
  final int index;

  @override
  State<NowDialog> createState() => _NowDialogState();
}

class _NowDialogState extends State<NowDialog> {
  late DatabaseReference _mFood;
  late DatabaseReference _mWater;
  late DatabaseReference _volumeFood;
  late DatabaseReference _volumeWater;
  late int dropdownValue = 100;

  @override
  void initState() {
    super.initState();
    _mFood = FirebaseDatabase.instance.ref().child('ESP/SERVO');
    _mWater = FirebaseDatabase.instance.ref().child('ESP/PUMP');
    _volumeFood = FirebaseDatabase.instance.ref().child('ESP/MASS');
    _volumeWater = FirebaseDatabase.instance.ref().child('ESP/VOLUME');
  }

  void choose() async {
    if (context.read<settingState>().lMainModel[widget.index].progress < 100) {
      context.read<settingState>().upDateLMainModel(widget.index, dropdownValue / 10);
      Navigator.of(context).pop();
      if (context.read<settingState>().type) {
        _mFood.set(1);
        _volumeFood.set(dropdownValue);
        await Future.delayed(const Duration(milliseconds: 1000), () {
          _mFood.set(0); 
        });
      } else {
        _mWater.set(1);
        _volumeWater.set(dropdownValue);
        await Future.delayed(Duration(milliseconds:dropdownValue *10), () {
          _mWater.set(0);
        });
      }
    } else {
      print('full');
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 200,
        child: Column(
          children: [
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
