import 'package:flutter/material.dart';
import 'package:note_app_with_php/app/component/crud.dart';
import 'package:note_app_with_php/app/constant/linkapi.dart';

import '../component/custometext.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _LoginState();
}

class _LoginState extends State<SingUp> {
  Crud crud = Crud();
  final TextEditingController userName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    singup() async {
      var respons = await crud.postReques(linkSignUp, {
        "name": userName.text,
        "email": email.text,
        "password": password.text
      });
      print('welcom');
      if (respons['status'] == "success") {
        print('hello');
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        print('sign up failed');
      }
    }

    hello() {
      print('hello');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("SingUp"),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomInput(
                label: 'username',
                controller: userName,
                hint: '',
              ),
              CustomInput(
                label: 'eamil',
                controller: email,
                hint: '',
              ),
              CustomInput(
                label: 'password',
                controller: password,
                hint: '',
              ),
              MaterialButton(
                onPressed: () async {
                  print(email.text);
                  await singup();

                  hello();

                  print('hi');
                },
                color: Colors.blueAccent,
                child: const Text('Sing Up'),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('login');
                },
                color: Colors.amber,
                child: const Text('login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
