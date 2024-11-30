import 'package:firebase/ui/home_screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/toast_popup.dart';

class SignInProvider extends ChangeNotifier{
  bool isLoading = false;
  TextEditingController tecEmail = TextEditingController();
  TextEditingController tecPassword = TextEditingController();


  FirebaseAuth auth = FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();


  void login(context) {

      isLoading = true;
    notifyListeners();
    auth
        .signInWithEmailAndPassword(
        email: tecEmail.text.toString().trim(),
        password: tecPassword.text.toString().trim())
        .then((v) {

        isLoading = false;
        tecEmail.clear();
        tecPassword.clear();
      notifyListeners();
      ToastMsg().toast('Sign In successful', Colors.green, Colors.white);
Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
    }).onError((Error, v) {
      ToastMsg().toast(Error.toString(), Colors.red, Colors.white);

        isLoading = false;
      notifyListeners();
    });
  }
}