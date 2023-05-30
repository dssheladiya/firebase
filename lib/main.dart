import 'package:firebase/1.1_login.dart';
import 'package:firebase/user_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import '1.2_logout.dart';
import '1_sing_in.dart';
import 'View/google sign.dart';
import 'otp/send_otp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final box1 = GetStorage();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: GoogleDemo(),
      // box1.read('userid') == null ? Sing() : Logout(),
    );
  }
}
//3.7.3
