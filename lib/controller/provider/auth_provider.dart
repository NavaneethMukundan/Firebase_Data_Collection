import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_first_project/controller/controller.dart';
import 'package:firebase_first_project/controller/provider/sign_up.dart';
import 'package:firebase_first_project/model/model_data.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  final auth = FirebaseAuth.instance;

  final userNameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  ModelClass userData = ModelClass();
  ModelClass loggedUserDetails = ModelClass();

  updateUserDetails(context) async {
    final userName = userNameController.text;
    final age = ageController.text;
    final address = addressController.text;
    final image = Provider.of<SignUpProvider>(context, listen: false).newImage;

    if (userName.isEmpty) {
      return Utility.checkFormFill(context, "incorrect value");
    }
    User? user = auth.currentUser;

    emailController.text = user!.email.toString();

    FirebaseFirestore.instance.collection("users").doc(user.uid).update({
      'name': userName,
      'age': age,
      'address': address,
      'image': image
      // 'profile': newImage.isEmpty ? profile : newImage
    }).then((value) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get()
          .then((value) {
        loggedUserDetails = ModelClass.fromJson(value.data()!);
      });
    });
    Utility.checkFormFill(context, "Data Update Successfully");
  }

  String newImage = "";
  updateImageFromGallery(context) async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    final bytes = File(pickedFile!.path).readAsBytesSync();
    newImage = base64Encode(bytes);
    notifyListeners();
  }
}
