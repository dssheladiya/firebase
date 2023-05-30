import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleDemo extends StatefulWidget {
  const GoogleDemo({Key? key}) : super(key: key);

  @override
  State<GoogleDemo> createState() => _GoogleDemoState();
}

class _GoogleDemoState extends State<GoogleDemo> {
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("sing in"),
              onPressed: () async {
                GoogleSignInAccount? account = await googleSignIn.signIn();
                GoogleSignInAuthentication authentication =
                    await account!.authentication;
                OAuthCredential credential = GoogleAuthProvider.credential(
                    accessToken: authentication.accessToken,
                    idToken: authentication.idToken);
                UserCredential userCredential =
                    await auth.signInWithCredential(credential);

                log("${userCredential.user!.displayName}");
                log("${userCredential.user!.uid}");
                log("${userCredential.user!.photoURL}");
                log("${userCredential.user!.email}");
                // box.write("userid", "${userCredential.user!.uid}");
              },
            ),
            ElevatedButton(
              child: Text("long out"),
              onPressed: () async {
                await googleSignIn.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
