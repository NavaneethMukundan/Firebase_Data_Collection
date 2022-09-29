import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_first_project/controller/controller.dart';
import 'package:firebase_first_project/model/model_data.dart';
import 'package:firebase_first_project/view/home/home.dart';
import 'package:flutter/material.dart';

class LogInProvider extends ChangeNotifier {
  final fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  final formKeys = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Stream<User?> stream() => _auth.authStateChanges();
  ModelClass loggedUserDetails = ModelClass();

  bool isLoading = false;

  Future<String> logInUser(context) async {
    isLoading = true;
    notifyListeners();
    try {
      await _auth
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) {
        getAllUserData(context);
      });
      isLoading = false;
      notifyListeners();
      return Future.value("");
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      isLoading = false;
      notifyListeners();
      return Utility.checkFormFill(context, e.message);
    }
  }

  formValidation(BuildContext context) async {
    if (formKeys.currentState!.validate()) {
      logInUser(context);
    }
  }

  getAllUserData(context) async {
    User? user = _auth.currentUser;
    await fireStore.collection("users").doc(user!.uid).get().then((value) => {
          loggedUserDetails = ModelClass.fromJson(value.data()!),
          notifyListeners(),
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeScren(type: ActionType.logIn),
            ),
          ),
        });
  }
}
