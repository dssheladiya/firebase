import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({Key? key, required this.id, this.toKen}) : super(key: key);
  final String id;
  final toKen;
  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  TextEditingController otp = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  int second = 30;
  bool isResend = false;

  void Timerdemo() {
    Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});

      second--;
      if (second == 0) {
        timer.cancel();
        setState(() {
          second = 30;
          isResend = true;
        });
      }
    });
  }

  @override
  void initState() {
    Timerdemo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$second"),
            isResend
                ? ElevatedButton(
                    onPressed: () async {
                      auth.verifyPhoneNumber(
                        phoneNumber: "+91 7567531134",
                        verificationCompleted: (phoneAuthCredential) {
                          log("verifyed");
                        },
                        verificationFailed: (error) {
                          log("ERROR");
                        },
                        codeSent: (verificationId, forceResendingToken) {
                          setState(() {});
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {
                          log("Time out");
                        },
                        forceResendingToken: widget.toKen,
                      );
                      setState(() {});
                      isResend = false;
                      Timerdemo();
                    },
                    child: Text('resend otp'))
                : SizedBox(),
            SizedBox(height: 30),
            TextField(
              controller: otp,
              decoration: InputDecoration(
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text("Verify"),
              onPressed: () async {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: widget.id, smsCode: otp.text);
                UserCredential userCredential =
                    await auth.signInWithCredential(credential);
                log("${userCredential.user!.phoneNumber}");
                log("${userCredential.user!.uid}");
              },
            ),
          ],
        ),
      ),
    );
  }
}
