import 'dart:developer';

import 'package:firebase/otp/verify_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SendOtp extends StatefulWidget {
  const SendOtp({Key? key}) : super(key: key);

  @override
  State<SendOtp> createState() => _SendOtpState();
}

class _SendOtpState extends State<SendOtp> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Send"),
          onPressed: () async {
            await auth.verifyPhoneNumber(
              phoneNumber: "+91 7567531134",
              verificationCompleted: (phoneAuthCredential) {
                log("verified");
              },
              verificationFailed: (error) {
                log("ERROR");
              },
              codeSent: (verificationId, forceResendingToken) {
                Get.to(VerifyOtp(id: verificationId));
              },
              codeAutoRetrievalTimeout: (verificationId) {
                log('TIME OUT');
              },
            );
          },
        ),
      ),
    );
  }
}
