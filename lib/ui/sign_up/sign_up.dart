import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/ui/home_screen/home_screen.dart';
import 'package:firebase/ui/sign_in/sigin_in.dart';
import 'package:firebase/utils/toast_popup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

bool isShow = false;

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController tecEmail = TextEditingController();
  final TextEditingController tecPassword = TextEditingController();
  final TextEditingController tecUsername = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore ref = FirebaseFirestore.instance;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter UserName";
                        }
                        return null;
                      },
                      controller: tecUsername,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Enter your Username',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Email";
                        }
                        return null;
                      },
                      controller: tecEmail,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Password";
                        }
                        return null;
                      },
                      controller: tecPassword,
                      obscureText: true,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Enter your Password',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          setState(() {
                            isLoading = true;
                          });
                          auth
                              .createUserWithEmailAndPassword(
                                  email: tecEmail.text.trim(),
                                  password: tecPassword.text.trim())
                              .then((v) {
                            ref
                                .collection('users')
                                .doc(auth.currentUser!.uid)
                                .set({
                              'email': tecEmail.text.toString().trim(),
                            }).then((value) {
                              ToastMsg().toast(
                                  "User data stored", Colors.red, Colors.amber);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const HomeScreen()));
                              tecPassword.clear();
                              tecEmail.clear();
                            });

                            setState(() {
                              isLoading = false;
                            });
                          }).catchError((error) {
                            // Handle error
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(error.toString()),
                                backgroundColor: Colors.amber,
                              ),
                            );
                            setState(() {
                              isLoading = false;
                            });
                          });
                        }
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
                                    'Sign up',
                                    style: TextStyle(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.bold),
                                  )),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text(
                            "Login in",
                            style: TextStyle(color: Colors.red, fontSize: 15),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
