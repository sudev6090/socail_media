import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:socail_api/model/authentication_model.dart';
import 'package:socail_api/service/authenticatio_func.dart';
import 'package:socail_api/view/screen/login_screen.dart';

class SignUpScreen extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    hintText: 'email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'enter a valid email';
                  } else {
                    return null;
                  }
                },
              ),
              const Gap(20),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                    hintText: 'password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'enter a valid password';
                  } else {
                    return null;
                  }
                },
              ),
              const Gap(20),
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                    hintText: 'username',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'enter a valid username';
                  } else {
                    return null;
                  }
                },
              ),
              FloatingActionButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    AuthService().signup(
                        context,
                        AuthenticationModel(
                            email: emailController.text,
                            password: passwordController.text,
                            username: usernameController.text));
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                  }
                },
                child: const Text('sign Up'),
              )
            ],
          ),
        ),
      ),
    );
  }
}