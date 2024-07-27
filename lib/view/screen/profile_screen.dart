import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:socail_api/model/authentication_model.dart';
import 'package:socail_api/service/authenticatio_func.dart';
import 'package:socail_api/view/screen/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: AuthService().getLoggedUser(context),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final UserModel? user = snapshot.data;
          if (user != null) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.black),
                elevation: 0,
                backgroundColor: Colors.white,
                title: Text(
                  user.username ?? 'Profile',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: ((BuildContext context) {
                              return AlertDialog(
                                title: const Text('logout'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('cancel')),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
                                    },
                                    child: const Text('log out'),
                                  )
                                ],
                              );
                            }));
                      },
                      icon: const Icon(Icons.logout)),
                ],
              ),
              body: Container(
                height: 230,
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CircleAvatar(
                            minRadius: 40,
                            backgroundColor: Colors.blueAccent,
                          ),
                          const Gap(20),
                          Column(
                            children: [
                              Text(
                                user.following!.length.toString(),
                              ),
                              const Text('Followers')
                            ],
                          ),
                          const SizedBox(width: 15),
                          Column(
                            children: [
                              Text(
                                user.followers!.length.toString(),
                              ),
                              const Text('Following')
                            ],
                          ),
                        ],
                      ),
                      const Gap(40),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                              minimumSize: WidgetStateProperty.all(
                                  const Size(140, 40)),
                            ),
                            child: const Text(
                              'Edit profile',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          const Gap(10),
                          ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                              minimumSize: WidgetStateProperty.all(
                                  const Size(140, 40)),
                            ),
                            child: const Text(
                              'Share profile',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          const Gap(20),
                          ElevatedButton(
                              onPressed: () {},
                              child: const Icon(Icons.person_add))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Text('');
          }
        }
      },
    );
  }
}