import 'dart:convert';
import 'package:firebase_first_project/controller/provider/auth_provider.dart';
import 'package:firebase_first_project/controller/provider/login.dart';
import 'package:firebase_first_project/controller/provider/sign_up.dart';
import 'package:firebase_first_project/view/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeImageSetUp extends StatelessWidget {
  const HomeImageSetUp({Key? key, required this.type}) : super(key: key);

  final ActionType type;

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.watch<LogInProvider>();
    final editProvider = context.watch<AuthProvider>();
    return Consumer<SignUpProvider>(
      builder: (context, value, child) {
        return GestureDetector(
            onTap: () {
              editProvider.updateImageFromGallery(context);
            },
            child: type == ActionType.signUp
                ? value.newImage.isEmpty || editProvider.newImage.isEmpty
                    ? const CircleAvatar(
                        radius: 100,
                      )
                    : CircleAvatar(
                        radius: 100,
                        //   backgroundColor: kBlack,
                        backgroundImage: MemoryImage(
                          const Base64Decoder().convert(value.newImage),
                        ),
                      )
                : loginProvider.loggedUserDetails.image == null
                    ? const CircleAvatar(
                        radius: 100,
                      )
                    : editProvider.newImage.isNotEmpty
                        ? CircleAvatar(
                            radius: 100,
                            //   backgroundColor: kBlack,
                            backgroundImage: MemoryImage(
                              const Base64Decoder()
                                  .convert(editProvider.newImage),
                            ),
                          )
                        : CircleAvatar(
                            radius: 100,
                            //   backgroundColor: kBlack,
                            backgroundImage: MemoryImage(
                              const Base64Decoder().convert(loginProvider
                                  .loggedUserDetails.image
                                  .toString()),
                            ),
                          ));
      },
    );
  }
}
