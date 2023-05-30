import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.userid}) : super(key: key);

  final String userid;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DocumentReference? users;

  GoogleSignIn googleSignIn = GoogleSignIn();
  final box1 = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    users = FirebaseFirestore.instance.collection('users').doc(widget.userid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: StreamBuilder(
                stream: users!.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data;
                    TextEditingController firstnamecontroller =
                        TextEditingController(text: data!['FirstName']);
                    TextEditingController lastnamecontroller =
                        TextEditingController(text: data!['LastName']);
                    TextEditingController emailcontroller =
                        TextEditingController(text: data!['Email']);
                    TextEditingController passcrolontler =
                        TextEditingController(text: data!['Password']);
                    return Column(
                      children: [
                        Text(
                          '${data['FirstName']}',
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          '${data['LastnName']}',
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          '${data['Email']}',
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          '${data['Password']}',
                          style: TextStyle(fontSize: 25),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          child: Text('Edit'),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                      child: Container(
                                        height: 300,
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextField(
                                                controller: firstnamecontroller,
                                                decoration: InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  labelText: "FirstName",
                                                ),
                                              ),
                                              SizedBox(height: 30),
                                              TextField(
                                                controller: lastnamecontroller,
                                                decoration: InputDecoration(
                                                  labelText: "LastName",
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              ElevatedButton(
                                                child: Text('update'),
                                                onPressed: () {
                                                  users?.update({
                                                    'FirstName':
                                                        firstnamecontroller
                                                            .text,
                                                    'LastName':
                                                        lastnamecontroller.text,
                                                  });
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ));
                          },
                        )
                      ],
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () async {
                await googleSignIn.signOut();
                await box1.erase();

                //Get.to(Login());
              },
              child: Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
