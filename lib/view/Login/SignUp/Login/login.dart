import 'package:firebase_first_project/controller/provider/login.dart';
import 'package:firebase_first_project/view/Login/SignUp/SignUp/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginController = context.read<LogInProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Form(
          key: loginController.formKeys,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Image.network(
                    'https://img.freepik.com/free-vector/computer-login-concept-illustration_114360-7892.jpg?w=2000'),
                const Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: loginController.emailController,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Email";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  obscureText: true,
                  controller: loginController.passwordController,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter password";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () {
                      loginController.formValidation(context);
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.green[400]),
                    child: loginController.isLoading == true
                        ? const CircularProgressIndicator(
                            strokeWidth: 2,
                          )
                        : const Text('Sign in ')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const SignUpPage()));
                        },
                        child: const Text("Don't have an Account?")),
                    TextButton(
                        onPressed: () {},
                        child: const Text('Forgot Password?')),
                  ],
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
                              'Sign in with Google',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )))
              ],
            ),
          ),
        )),
      ),
    );
  }
}
