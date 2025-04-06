import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iot_app/configs/color.dart';
import 'package:iot_app/v2/history_screen.dart';
import 'package:iot_app/model/main_model.dart';
import 'package:iot_app/controller/setting_state.dart';
import 'package:iot_app/services/alert_dialog.dart';
import 'package:provider/provider.dart';

import '../services/now_dialog.dart';

class TopFunction extends StatefulWidget {
  const TopFunction({super.key, required this.mainModel});
  final List<MainModel> mainModel;

  @override
  State<TopFunction> createState() => _TopFunctionState();
}

class _TopFunctionState extends State<TopFunction> {
  late ScrollController scrollController;
  DateTime currentDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    scrollController =
        ScrollController(initialScrollOffset: 70.0 * currentDateTime.day);
  }

  Widget hrizontalCapsuleListView() {
    return SizedBox(
      width: double.infinity,
      height: 130,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.mainModel.length,
        itemBuilder: (BuildContext context, int index) {
          return capsuleView(index);
        },
      ),
    );
  }

  Widget capsuleView(int index) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () {
            setState(() {
              currentDateTime = widget.mainModel[index].dateTime;
            });
          },
          child: Container(
            width: 70,
            height: widget.mainModel[index].dateTime.day == currentDateTime.day
                ? 80
                : 100,
            decoration: BoxDecoration(
                color: const Color(0xFF333333),
                borderRadius: BorderRadius.circular(50)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.mainModel[index].dateTime.day.toString(),
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: (widget.mainModel[index].dateTime.day ==
                                currentDateTime.day)
                            ? Colors.amber
                            : Colors.white),
                  ),
                  Text(
                    DateFormat('EEE').format(widget.mainModel[index].dateTime),
                    style: TextStyle(
                        fontSize: 15,
                        color: (widget.mainModel[index].dateTime.day ==
                                currentDateTime.day)
                            ? Colors.amber
                            : Colors.white),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget topView() {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            hrizontalCapsuleListView(),
            Padding(
              padding: EdgeInsets.only(right: 10,top: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Lịch sử',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    SizedBox(width: 5),
                    Icon(Icons.arrow_forward_ios,color: Colors.grey.shade400,size: 12,)
                  ],
                ),
              ),
            )
          ]),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 20, top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 130,
                width: 130,
                child: Stack(children: [
                  DashedCircularProgressBar.aspectRatio(
                    valueNotifier: ValueNotifier(
                        widget.mainModel[currentDateTime.day - 1].progress),
                    aspectRatio: 1,
                    progress:
                        widget.mainModel[currentDateTime.day - 1].progress,
                    startAngle: 200,
                    sweepAngle: 320,
                    foregroundColor: widget.mainModel[0].type == 0
                        ? kColorFood
                        : kColorWater,
                    backgroundColor: Color(0x3373C08F),
                    foregroundStrokeWidth: 5,
                    backgroundStrokeWidth: 3,
                    animation: true,
                    seekSize: 0,
                    seekColor: const Color(0xffeeeeee),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return NowDialog(index: currentDateTime.day - 1);
                            },
                          );
                        },
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    widget.mainModel[currentDateTime.day - 1]
                                        .progress
                                        .toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const WaterDialog();
                        },
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.calendar_month),
                          Selector<settingState,String>(
                            selector: (ctx,state) => widget.mainModel[0].type == 0 ? state.alertTimeFood : state.alertTimeWater,
                            builder: (context, value, _) {
                              if(value != ""){
                                return Text(value,style: const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold));
                              }
                              else{
                                return SizedBox();
                              }
                            },                     
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Selector<settingState, String>(
                      selector: (ctx, state) => widget.mainModel[0].type == 0
                          ? state.volumeTimeFood
                          : state.volumeTimeWater,
                      builder: (context, value, _) {
                        return Text("${value}ml",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20));
                      }),
                ],
              ),
            ],
          ),
        ),
        topView(),
      ],
    );
  }
}
