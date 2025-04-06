// import 'package:flutter/material.dart';
// import 'package:iot_app/setting_state.dart';
// import 'package:provider/provider.dart';

// import 'model/history_model.dart';

// class HistoryScreen extends StatefulWidget {
//   const HistoryScreen({super.key});

//   @override
//   State<HistoryScreen> createState() => _HistoryScreenState();
// }

// class _HistoryScreenState extends State<HistoryScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Lịch sử'),
//         centerTitle: true,
//       ),
//       body: Selector<settingState, List<History>>(
//         selector: (ctx, state) => state.history,
//         builder: (context, value, child) {
//           return Container(
//             padding: const EdgeInsets.symmetric(horizontal: 15),
//             child: ListView.builder(
//               itemCount: value.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.only(top: 15),
//                   child: Container(
//                     padding: EdgeInsets.only(bottom: 15),
//                     decoration: BoxDecoration(
//                       border: Border(
//                         bottom: BorderSide(
//                           width: 1,
//                           color: Color(0xFFD4D4D4)
//                         )
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Icon(value[index].type == 0 ? Icons.fastfood : Icons.local_drink_rounded,
//                             color: value[index].type == 0 ? Color(0xFF40C877) : Color(0xFFFF8777),
//                             size: 30,
//                             ),
//                             const SizedBox(width: 20),
//                             Text(value[index].progress),
//                           ],
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Text("${value[index].dateTime.day}/${value[index].dateTime.month}/${value[index].dateTime.year}"),
//                             Text("${value[index].dateTime.hour}:${value[index].dateTime.minute}"),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             )
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iot_app/controller/setting_state.dart';
import 'package:iot_app/model/history_model.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("History",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
      ),
      body: Selector<settingState,List<HistoryModel>>(
        selector: (ctx, state) => state.lHistory,
        builder: (ctx, value, _) {
          return Container(
          decoration: const BoxDecoration(
            color: Colors.black
          ),
          child: ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Time'),
                          Text('${value[index].dateTime.year}/${value[index].dateTime.month}/${value[index].dateTime.day}',
                          style: const TextStyle(color: Colors.black,fontSize: 15)),
                          Text('${value[index].dateTime.hour}:${value[index].dateTime.minute}',
                          style: const TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Image(image: value[index].type ? const AssetImage('assets/icons/food.png') : const AssetImage('assets/icons/water.png'))),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Volume'),
                          Text('${value[index].volume/10}',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  )),
              );
            },),
        );
        },
      )
    );
  }
}