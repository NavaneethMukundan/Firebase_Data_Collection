import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_first_project/controller/controller.dart';
import 'package:firebase_first_project/model/model_data.dart';
import 'package:firebase_first_project/view/home/home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUpProvider with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final ageController = TextEditingController();
  final addressController = TextEditingController();

  ModelClass userData = ModelClass();
  ModelClass loggedUserDetails = ModelClass();
  //dynamic newUser;

  Future<String> signUpUser(context) async {
    final password = passwordController.text;

    if (password.length < 6 || newImage.isEmpty) {}
    try {
      _auth
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) => addAllUserDetails(context, newImage));
      return Future.value("");
    } on FirebaseAuthException catch (e) {
      log("$e");
      return Utility.checkFormFill(context, e.message);
    }
  }

  Future addAllUserDetails(context, String newImage) async {
    final fireSore = FirebaseFirestore.instance;

    User? user = _auth.currentUser;
    userData.email = user!.email!.trim();
    userData.name = userNameController.text.trim();
    userData.image = newImage;
    userData.age = ageController.text.isEmpty ? null : ageController.text;
    userData.address = addressController.text.trim();
    await fireSore
        .collection("users")
        .doc(user.uid)
        .set(
          userData.toJson(),
        )
        .then(
      (value) {
        fireSore.collection("users").doc(user.uid).get().then((value) {
          loggedUserDetails = ModelClass.fromJson(value.data()!);
          notifyListeners();
        });
      },
    );
    notifyListeners();

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: ((context) => HomeScren(type: ActionType.signUp)),
        ),
        ((route) => false));
  }

  String newImage = "";
  getImageFromGallery(conteex) async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    final bytes = File(pickedFile!.path).readAsBytesSync();
    newImage = base64Encode(bytes);
    notifyListeners();
  }
}
