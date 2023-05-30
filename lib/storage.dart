import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class DemoStorage extends StatefulWidget {
  const DemoStorage({Key? key}) : super(key: key);

  @override
  State<DemoStorage> createState() => _DemoStorageState();
}

class _DemoStorageState extends State<DemoStorage> {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await box.write("userid", "123456789");
                },
                child: Text("add"),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  print("${box.read("username")}");
                  print("${box.read("userid")}");
                },
                child: Text("get"),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  await box.remove("username");
                },
                child: Text("remove"),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  //await box.erase();
                },
                child: Text("remove All"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
