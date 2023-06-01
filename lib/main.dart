import 'package:flutter/material.dart';
import 'package:note_app_with_php/app/notes/addnote.dart';
import 'package:note_app_with_php/app/notes/editnote.dart';

import 'app/auth/login.dart';
import 'app/auth/signup.dart';
import 'app/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedpref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sharedpref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter with php ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: sharedpref.getString('id') == null ? "login" : "home",
      routes: {
        "login": (context) => const Login(),
        "SingUp": (context) => const SingUp(),
        "home": (context) => const Home(),
        "addNote": (context) => const AddNote(),
        "editNote": (context) => const EditNote(),
      },
    );
  }
}
