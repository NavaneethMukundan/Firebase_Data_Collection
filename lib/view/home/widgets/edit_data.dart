import 'package:firebase_first_project/controller/provider/auth_provider.dart';
import 'package:firebase_first_project/controller/provider/login.dart';
import 'package:firebase_first_project/controller/provider/sign_up.dart';
import 'package:firebase_first_project/view/home/home.dart';
import 'package:firebase_first_project/view/home/widgets/home_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatelessWidget {
  ActionType type;
  EditScreen({Key? key, required this.type})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.watch<LogInProvider>();
    final editProvider = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Home')),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Consumer<SignUpProvider>(
              builder: (context, value, child) {
                return Column(
                  children: [
                    HomeImageSetUp(type: type),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: editProvider.userNameController,
                      obscureText: false,
                      autofocus: false,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: type == ActionType.logIn
                            ? loginProvider.loggedUserDetails.name
                            : value.loggedUserDetails.name,
                        hintStyle: const TextStyle(fontSize: 20),
                        border: const OutlineInputBorder(),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: editProvider.ageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: loginProvider.loggedUserDetails.age!.isEmpty
                            ? ''
                            : loginProvider.loggedUserDetails.age,
                        border: const OutlineInputBorder(),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: editProvider.addressController,
                      decoration: InputDecoration(
                        hintText:
                            loginProvider.loggedUserDetails.address!.isEmpty
                                ? ''
                                : loginProvider.loggedUserDetails.address,
                        border: const OutlineInputBorder(),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer<AuthProvider>(
                      builder: (context, value, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                editProvider.updateUserDetails(context);
                                value.notifyListeners();
                                editProvider.notifyListeners();
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(150, 30),
                              ),
                              child: const Text('Done'),
                            ),
                          ],
                        );
                      },
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
