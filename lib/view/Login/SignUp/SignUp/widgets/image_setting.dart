import 'dart:convert';
import 'package:firebase_first_project/controller/provider/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageSetUp extends StatelessWidget {
  const ImageSetUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () {
            value.getImageFromGallery(context);
          },
          child: value.newImage.isNotEmpty
              ? CircleAvatar(
                  radius: 50,
                  //   backgroundColor: kBlack,
                  backgroundImage: MemoryImage(
                    const Base64Decoder().convert(value.newImage),
                  ),
                )
              : const CircleAvatar(
                  radius: 50,
                  //   backgroundColor: kBlack,
                  backgroundImage: AssetImage('Assets/images/Ny.jpg')),
        );
      },
    );
  }
}
