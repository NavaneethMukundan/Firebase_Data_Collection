import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_first_project/controller/provider/login.dart';
import 'package:firebase_first_project/controller/provider/sign_up.dart';
import 'package:firebase_first_project/view/Login/SignUp/Login/login.dart';
import 'package:firebase_first_project/view/home/widgets/edit_data.dart';
import 'package:firebase_first_project/view/home/widgets/home_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ActionType {
  logIn,
  signUp,
}

class HomeScren extends StatelessWidget {
  ActionType type;
  HomeScren({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.watch<LogInProvider>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(child: Text('Home')),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false);
              });
            },
            icon: const Icon(Icons.logout),
            splashRadius: 20,
          )
        ],
      ),
      body: Consumer<SignUpProvider>(builder: (context, value, child) {
        return Center(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: SizedBox(
                        height: 250,
                        width: 400,
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              HomeImageSetUp(type: type),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                type == ActionType.logIn
                                    ? loginProvider.loggedUserDetails.name
                                        .toString()
                                    : value.loggedUserDetails.name.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 60,
                      width: 400,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black)),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            'Age :',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            type == ActionType.logIn
                                ? loginProvider.loggedUserDetails.age.toString()
                                : value.loggedUserDetails.age.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 60,
                      width: 400,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black)),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            'Email :',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            type == ActionType.logIn
                                ? loginProvider.loggedUserDetails.email
                                    .toString()
                                : value.loggedUserDetails.email.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 60,
                        width: 400,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black)),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              'Address :',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              type == ActionType.logIn
                                  ? loginProvider.loggedUserDetails.address
                                      .toString()
                                  : value.loggedUserDetails.address.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => EditScreen(
                                        type: ActionType.logIn,
                                      )));
                        },
                        child: const Text('Edit Data'))
                  ],
                )));
      }),
    );
  }
}
