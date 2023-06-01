import 'package:flutter/material.dart';
import 'package:note_app_with_php/app/constant/linkapi.dart';
import 'package:note_app_with_php/main.dart';

import '../component/crud.dart';
import '../component/custometext.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Crud crud = Crud();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool isloading = false;
  login() async {
    isloading = true;
    setState(() {});
    var respons = await crud.postReques(
        linkLogin, {"email": email.text, "password": password.text});

    if (respons['status'] == "success Login") {
      print(respons['status']);
      sharedpref.setString("id", respons['data']['id'].toString());
      sharedpref.setString("email", respons['data']['email'].toString());
      sharedpref.setString("name", respons['data']['name'].toString());

      print(respons['data']['name']);
      Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
    } else {
      print('sign up failed');
    }
    isloading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                  await login();
                },
                color: Colors.amber,
                child: isloading == true
                    ? const Text('loading ....')
                    : const Text('Login'),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('SingUp');
                },
                color: Colors.blueAccent,
                child: const Text('Sing Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
