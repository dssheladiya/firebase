import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '1.2_logout.dart';
import '1_sing_in.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final box1 = GetStorage();
  bool loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    hintText: "Enter Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 10),
              TextField(
                  controller: passcontroller,
                  decoration: InputDecoration(
                    hintText: "Enter password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  keyboardType: TextInputType.visiblePassword),
              const SizedBox(height: 10),
              loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      child: const Text("Login"),
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        try {
                          UserCredential credential =
                              await auth.createUserWithEmailAndPassword(
                                  email: emailcontroller.text,
                                  password: passcontroller.text);

                          print("${credential.user!.email}");
                          print("${credential.user!.uid}");

                          box1.write(
                            "userid",
                            "${credential.user!.uid}",
                          );
                          setState(() {
                            loading = false;
                          });
                          Get.to(const Logout());
                        } on FirebaseAuthException catch (e) {
                          print("${e.code}");
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("${e.message}")));
                          setState(() {
                            loading = false;
                          });
                        }
                      },
                    ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(" Olredy you have account?"),
                  const SizedBox(width: 5),
                  InkResponse(
                    onTap: () {
                      Get.to(const Sing());
                    },
                    child: const Text(
                      "Sign in",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
