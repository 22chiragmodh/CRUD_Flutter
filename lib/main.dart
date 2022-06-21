import 'package:flutter/material.dart';
import 'screens/crud_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/registration_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.cyan)),
      home:const Register(),
       routes: {
        '/loginpage' : (BuildContext context) =>const CRUDPage(),
      },
    );
  }
}
