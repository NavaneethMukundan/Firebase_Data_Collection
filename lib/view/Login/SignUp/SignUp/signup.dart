import 'package:firebase_first_project/controller/provider/sign_up.dart';
import 'package:firebase_first_project/view/Login/SignUp/Login/login.dart';
import 'package:firebase_first_project/view/Login/SignUp/SignUp/widgets/image_setting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signUpController = context.read<SignUpProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      signUpController.emailController.clear();
      signUpController.passwordController.clear();
      signUpController.userNameController.clear();
      signUpController.notifyListeners();
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<SignUpProvider>(builder: (context, value, child) {
            return Form(
              key: value.formKey,
              child: Column(
                children: [
                  Center(
                    child: Image.network(
                      'https://img.freepik.com/free-vector/sign-up-concept-illustration_114360-7895.jpg?w=2000',
                      height: 300,
                    ),
                  ),
                  const ImageSetUp(),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLength: 10,
                    controller: value.userNameController,
                    decoration: InputDecoration(
                        hintText: 'user Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    validator: (inputValue) {
                      if (inputValue == null || inputValue.isEmpty) {
                        return 'Please enter userName';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: value.ageController,
                    decoration: InputDecoration(
                        hintText: 'Age',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    validator: (inputValue) {
                      if (inputValue == null || inputValue.isEmpty) {
                        return 'Please enter age';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: value.addressController,
                    decoration: InputDecoration(
                        hintText: 'Address',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    validator: (inputValue) {
                      if (inputValue == null || inputValue.isEmpty) {
                        return 'Please enter address';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: value.emailController,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    validator: (inputValue) {
                      if (inputValue == null || inputValue.isEmpty) {
                        return 'Please enter email';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: value.passwordController,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    validator: (inputValue) {
                      if (inputValue == null || inputValue.isEmpty) {
                        return 'Please enter password';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (value.formKey.currentState!.validate()) {
                              signUpController.signUpUser(context);

                              // signUpController.checkFormField(
                              //     context, errorMsg);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green[400]),
                          child: const Text('Sing Up')),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: ((context) => const LoginPage())));
                          },
                          child: const Text('Already Sign Up?')),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: const Color.fromARGB(255, 214, 214, 214)),
                      child: Container(
                          height: 70,
                          width: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png',
                                height: 45,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Sign Up with Google',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )))
                ],
              ),
            );
          }),
        )),
      ),
    );
  }
}
