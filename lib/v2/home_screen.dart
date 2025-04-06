import 'package:flutter/material.dart';
import 'package:iot_app/v2/camera_screen.dart';
import 'package:iot_app/v2/home_type_screen.dart';
import 'package:iot_app/controller/setting_state.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Chăm sóc thú cưng",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        actions: [
          Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade700)),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CameraScreen(),));
                },
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 20,
                ),
              ))
        ],
      ),
      body: Selector<settingState, bool>(
          selector: (ctx, state) => state.type,
          builder: (context, value, _) {
            return HomeTypeScreen(type: value,);
          }),
    );
  }
}
