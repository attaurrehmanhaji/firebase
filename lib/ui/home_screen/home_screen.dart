import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DatabaseReference db= FirebaseDatabase.instance.ref("todo");
  XFile?image;
  File? imagePath;
  void picImage(){


  }

  @override
  Widget build(BuildContext context) {
    bool isLoading=false;
    return Scaffold(
        appBar: AppBar(
          title: Text("Home Screen"),
          actions: [
            TextButton.icon(onPressed: null, label: Icon(Icons.logout_rounded)),
            TextButton.icon(onPressed: null, label: Icon(Icons.delete)),
          ],
        ),
        body: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(

                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(

                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: "Discription",
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            GestureDetector(
              onTap:
              (){
                String id = DateTime.now().millisecondsSinceEpoch.toString();

              db.child(id).set({
                "title": titleController.text.trim().toString(),
                "discription": descriptionController.text.trim().toString(),
              });
              },
              child: Container(
                height: 60.h,
                width: 250.w,
                decoration: BoxDecoration(color: Colors.teal),
                child: Center(
                    child: isLoading
                        ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : Text(
                      'Add Data',
                      style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            GestureDetector(
              onTap: (){
                picImage();

              },
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                backgroundImage: AssetImage('assets/pic1.jfif'),

              ),
            )

          ],
        ));
  }
}
