// // ignore: file_names
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:iot_app/camera_screen.dart';
// import 'package:iot_app/history_screen.dart';
// import 'package:iot_app/setting_state.dart';
// import 'package:iot_app/waterdialog.dart';
// import 'package:provider/provider.dart';


// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final Future<FirebaseApp> _fApp = Firebase.initializeApp();

//   String LED = '0';
//   bool switchLed = false;
//   List<String> listFood = <String>['100g', '200g', '300g', '400g'];
//   List<String> listWater = <String>['100ml', '200ml', '300ml', '400ml'];
//   String dropdownFoodValue = "";
//   String dropdownWaterValue = "";
//   late DatabaseReference _testRef;
//   late DatabaseReference _alermWater;
//   late DatabaseReference _volumemWater;
//   late DatabaseReference _immediateWatering;
//   late DatabaseReference _immediateFood;
//   late DatabaseReference _nhietdo;
//   late DatabaseReference _doam;
//   bool stateDrink = false;

//   @override
//   void initState() {
//     super.initState();
//     dropdownFoodValue = listFood.first;
//     dropdownWaterValue = listWater.first;
//     fetchData();
//   }

//   void fetchData()  {
//     _testRef = FirebaseDatabase.instance.ref().child('ESP/LED');
//     _alermWater = FirebaseDatabase.instance.ref().child('ESP/SETTIME');
//     _volumemWater = FirebaseDatabase.instance.ref().child('ESP/VOLUME');
//     _immediateWatering = FirebaseDatabase.instance.ref().child('ESP/PUMP');
//     _immediateFood = FirebaseDatabase.instance.ref().child('ESP/SERVO');
//     _nhietdo = FirebaseDatabase.instance.ref().child('ESP/nhietdo');
//     _doam = FirebaseDatabase.instance.ref().child('ESP/doam');

//     _alermWater.onValue.listen((event) {
//       context.read<settingState>().updateTimeWater(event.snapshot.value.toString());
//     });
//     _volumemWater.onValue.listen((event) {
//       context.read<settingState>().updateVolumeWater(event.snapshot.value.toString());
//     });
//     _immediateWatering.onValue.listen((event) {
//     });
//     _testRef.onValue.listen((event){
//       setState(() {
//         LED = event.snapshot.value.toString();
//       });
//     });
//     _immediateFood.onValue.listen((event) {
//     });
//     _nhietdo.onValue.listen((event) {
//       context.read<settingState>().updateNhietDo(event.snapshot.value.toString());
//     });
//     _doam.onValue.listen((event) {
//       context.read<settingState>().updateDoAm(event.snapshot.value.toString());
//     });
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: FutureBuilder(
//           future: _fApp,
//           builder: (context, snapshot) {
//             if(snapshot.hasData){
//               return Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 decoration: const BoxDecoration(
//                   color: Color(0xFFF5F5F5)
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 15,right: 15,top: 30),
//                   child: Column(
//                     children: [
//                       light(),
//                       heightDivide(),
//                       buttonFeedPet(),
//                       heightDivide(),
//                       buttonPumpWater(),
//                       heightDivide(),
//                       const Text('Alarm',style: TextStyle(fontSize: 30),),
//                       alertWater(context),
//                       ElevatedButton(
//                         onPressed: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => const CameraScreen()));
//                       }, child: Icon(Icons.abc)),
//                       Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(17)
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Selector<settingState, String>(
//                             selector: (ctx, state) => state.nhietdo,
//                             builder: (context, value, _) {
//                               return Text("Nhiet do: ${value}",style: const TextStyle(color: Colors.black,fontSize: 26),);
//                             }
//                           ),
//                           Selector<settingState, String>(
//                             selector: (ctx, state) => state.doam,
//                             builder: (context, value, _) {
//                               return Text("Do am:${value}",style: const TextStyle(color: Colors.black,fontSize: 26));
//                             }
//                           ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }else{
//               return const CircularProgressIndicator(color: Colors.amber,);
//             }
//           },
//         ),
//         floatingActionButton: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             shape: const CircleBorder(),
//             shadowColor: Color(0xFFD4D4D4),
//           ),
//           onPressed: () {
//             Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryScreen(),));
//           }, 
//           child: const Icon(Icons.history, color: Color(0xFFBE5ED6),size: 30,))
//       ),
//     );
//   }

//   InkWell alertWater(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         showDialog(context: context, builder: (context) {
//           return const WaterDialog();
//         },);
//       },
//     child: Container(
//       padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(17)
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Selector<settingState, String>(
//             selector: (ctx, state) => state.alertTimeWater,
//             builder: (context, value, _) {
//               return Text("${value}",style: const TextStyle(color: Colors.black,fontSize: 26),);
//             }
//           ),
//           Selector<settingState, String>(
//             selector: (ctx, state) => state.volumeTimeWater,
//             builder: (context, value, _) {
//               return Text("${value}ml",style: const TextStyle(color: Colors.black,fontSize: 26));
//             }
//           ),
//           ],
//         ),
//       ),
//     );
//   }

//   Selector<settingState, String> buttonPumpWater() {
//     return Selector<settingState, String>(
//       selector: (ctx, state) => state.immediateWatering,
//       builder: (context, value, _) {
//         return Container(
//           padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
//           decoration: BoxDecoration(
//             color: value == '1' ? Colors.amber :Colors.white,
//             borderRadius: BorderRadius.circular(17)
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 decoration: const BoxDecoration(
//                 color: Colors.white),
//                 child: DropdownMenu<String>(
//                   inputDecorationTheme: const InputDecorationTheme(
                  
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(20)))),
//                   initialSelection: listWater.first,
//                   onSelected: (String? value) {
//                     setState(() {
//                       dropdownWaterValue = value!;
//                       _volumemWater.set(int.parse(dropdownWaterValue.substring(0,value.length-2)));
//                     });
//                   },
//                   dropdownMenuEntries: listWater.map<DropdownMenuEntry<String>>((String value) {
//                     return DropdownMenuEntry<String>(value: value, label: value);
//                   }).toList(),
//                 ),
//               ),
//               ElevatedButton(
//                 style: const ButtonStyle(
//                 backgroundColor: MaterialStatePropertyAll(Color(0xFF00B458)),
//                 shape: MaterialStatePropertyAll(CircleBorder()),
//                 padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
//                 elevation: MaterialStatePropertyAll(3)
//               ),
//                 onPressed: () async {
//                 context.read<settingState>().updateImmediateWatering("1");
//                 context.read<settingState>().pushHistory(DateTime.now(), dropdownWaterValue, 1);
//                 _immediateWatering.set(1);
//                 await Future.delayed(const Duration(milliseconds: 1000), () {
//                   _immediateWatering.set(0);
//                 });
//                 Future.delayed(Duration(milliseconds: int.parse(context.read<settingState>().volumeTimeWater)*10-1000), () {
//                   setState(() {
//                     context.read<settingState>().updateImmediateWatering("0");
//                   });
//                 });
//               }, 
//                 child: Icon(Icons.local_drink_rounded,color: Colors.white,)
//               )
//             ],
//           ),
//         ); 
//       }
//     );
//   }

//   Widget buttonFeedPet() {
//     return Selector<settingState, String>(
//       selector: (ctx, state) => state.immediateFood,
//       builder: (context, value, _) {
//         return Container(
//         padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
//         decoration: BoxDecoration(
//           color: value == '1' ? Colors.amber :Colors.white,
//           borderRadius: BorderRadius.circular(17)
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Container(
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//               ),
//               child: DropdownMenu<String>(
//                 inputDecorationTheme: const InputDecorationTheme(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(20)))),
//                 initialSelection: listFood.first,
//                 onSelected: (String? value) {
//                   setState(() {
//                     dropdownFoodValue = value!;
//                   });
//                 },
//                 dropdownMenuEntries: listFood.map<DropdownMenuEntry<String>>((String value) {
//                   return DropdownMenuEntry<String>(
//                     value: value, label: value);
//                   }).toList(),
//               ),
//             ),
//             const SizedBox(width: 30), 
//             ElevatedButton(
//               style: const ButtonStyle(
//                 backgroundColor: MaterialStatePropertyAll(Color(0xFF00B458)),
//                 shape: MaterialStatePropertyAll(CircleBorder()),
//                 padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
//                 elevation: MaterialStatePropertyAll(3)
//               ),
//               onPressed: () async {
//               context.read<settingState>().updateImmediateFood("1");
//               context.read<settingState>().pushHistory(DateTime.now(), dropdownFoodValue, 0);
//               _immediateFood.set(1);
//               await Future.delayed(const Duration(milliseconds: 1000), () {
//                 _immediateFood.set(0);
//               });
//               Future.delayed(Duration(milliseconds: int.parse(context.read<settingState>().volumeTimeWater)*10-1000), () {
//                 setState(() {
//                   context.read<settingState>().updateImmediateFood("0");
//                 });
//               });
//             }, 
//             child: const Icon(Icons.fastfood,color: Colors.white,))
//           ],
//         ),
//       );
//       }
//     );
//   }

//   SizedBox heightDivide() {
//     return const SizedBox(
//       height: 20,
//     );
//   }

//   Container light() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(17)
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Icon(Icons.light, color: (switchLed == true) ? Colors.orange : null,),
//           Switch(
//             value: switchLed, onChanged: (value) {
//             setState(() {
//               switchLed = value;
//               switchLed == false ? _testRef.set(0) :  _testRef.set(1); 
//             });
//           },),
//         ],
//       ),
//     );
//   }
// }