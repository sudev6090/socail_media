import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:socail_api/model/authentication_model.dart';
import 'package:socail_api/service/authenticatio_func.dart';
import 'package:socail_api/view/screen/widgets/bottom_nav.dart';
import 'package:socail_api/view/screen/widgets/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 38, 83, 143),
        elevation: 0,
        title: const Text(
          'Social Media',
          style: TextStyle(
              color: Color.fromARGB(255, 251, 250, 250),
              fontSize: 32,
              fontStyle: FontStyle.italic),
        ),
      ),
      body: Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 251, 249, 249)),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'enter email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'enter a email';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 21,
              ),
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
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignUpScreen()));
                  },
                  child: const Text(
                    'signup',
                    style: TextStyle(color: Color(0xFF405DE6), fontSize: 18),
                  )),
              const Gap(20),
              TextButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    final status = await AuthService().login(
                        context,
                        AuthenticationModel(
                            email: emailController.text,
                            password: passwordController.text));

                    if (status == 'success') {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const BottomNav()));
                    } else {
                      return;
                    }
                  }
                },
                child: const Text('login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
