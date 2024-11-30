import 'package:firebase/ui/sign_in/signin_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context)=>SignInProvider(),



      child: Consumer<SignInProvider>(
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: const Text('SIgn In'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: model.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      controller: model.tecEmail,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          hintText: 'Enter your email',
                          border: OutlineInputBorder(),
                          hintStyle: TextStyle(color: Colors.black)),
                    ),
                    SizedBox(height: 20.h),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      controller: model.tecPassword,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () {
                        if (model.formKey.currentState!.validate()) {
                          model.login(context);
                        }
                        model.tecEmail.clear();
                        model.tecPassword.clear();
                      },
                      child: Container(
                        height: 60.h,
                        width: 250.w,
                        decoration: BoxDecoration(color: Colors.teal),
                        child: Center(
                            child: model.isLoading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    'Sign In',
                                    style: TextStyle(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.bold),
                                  )),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
