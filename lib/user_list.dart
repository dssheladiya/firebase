import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  DocumentReference user = FirebaseFirestore.instance
      .collection("users")
      .doc("fNZ1DpNm5mVx65rQ4q7b");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        /// Add
        // users.add({
        //   'name': 'denish',
        //   'email': 'denish@gmail.com',
        // });

        /// Delete
        //user.delete();

        /// Update
        user.update({
          "name": "len",
          "email": "leno@gmail.com",
        });
      }),
      body: FutureBuilder(
        future: users.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data!.docs[0].data();

            return Center(child: Text("${data}"));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
