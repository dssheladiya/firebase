import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '1.1_login.dart';

class Logout extends StatefulWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  final box1 = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await box1.remove("userid");
                    Get.to(const Login());
                  },
                  child: const Text("LogOut"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// TextField(
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   labelText: "Email",
//                   prefixIcon: Icon(Icons.email),
//                 ),
//                 keyboardType: TextInputType.emailAddress,
//               ),
//               SizedBox(height: 10),
//               TextField(
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   labelText: "Password",
//                   prefixIcon: Icon(Icons.lock),
//                 ),
//                 keyboardType: TextInputType.visiblePassword,
//               ),
//               SizedBox(height: 10),
