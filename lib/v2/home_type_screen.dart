import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:iot_app/controller/setting_state.dart';
import 'package:iot_app/v2/chart_history.dart';
import 'package:iot_app/v2/top_function.dart';
import 'package:provider/provider.dart';

class HomeTypeScreen extends StatefulWidget {
  const HomeTypeScreen({super.key, required this.type});
  final bool type;

  @override
  State<HomeTypeScreen> createState() => _HomeTypeScreenState();
}

class _HomeTypeScreenState extends State<HomeTypeScreen> {
  Box mainBox = Hive.box('main');
  List<DateTime> currentMonthList = [];
  DateTime now = DateTime.now();
  late DatabaseReference temp;
  late DatabaseReference hum;
  late String tempValue = '';
  late String humValue = '';

  void dayInMonth() {
    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    for (DateTime i = firstDayOfMonth;
        i.isBefore(lastDayOfMonth.add(Duration(days: 1)));
        i = i.add(const Duration(days: 1))) {
      currentMonthList.add(i);
    }
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
  }

  @override
  void initState() {
    super.initState();
    dayInMonth();
    context.read<settingState>().fetchData(currentMonthList);
    context.read<settingState>().getLMainModel();
    temp = FirebaseDatabase.instance.ref('ESP/TEMP');
    temp.onValue.listen((DatabaseEvent event) {
      setState(() {
        tempValue = event.snapshot.value.toString();
      });
    });
    hum = FirebaseDatabase.instance.ref('ESP/HUM');
    hum.onValue.listen((DatabaseEvent event) {
      setState(() {
        humValue = event.snapshot.value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.black),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TopFunction(mainModel: context.read<settingState>().lMainModel),
          Container(
            height: 400,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.amber,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text('Temp')
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.purple,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text('Hum')
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 60,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    tempValue,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    'o',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            height: 40,
                            width: 60,
                            decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Text(
                                '$humValue%',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      AnimatedToggleSwitch.dual(
                        current: widget.type,
                        first: false,
                        second: true,
                        spacing: 20.0,
                        style: const ToggleStyle(
                            backgroundColor: Colors.black,
                            borderColor: Colors.black),
                        indicatorSize: const Size.fromWidth(45),
                        borderWidth: 5,
                        onChanged: (b) => setState(
                            () => context.read<settingState>().changeType(b)),
                        styleBuilder: (b) => ToggleStyle(
                          backgroundColor: Colors.black,
                          indicatorColor: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        textBuilder: (value) => value
                            ? const Center(
                                child: Text('Eat',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)))
                            : const Center(
                                child: Text('Drink',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18))),
                      ),
                    ],
                  ),
                  const ChartHistory()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
