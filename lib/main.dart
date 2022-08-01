import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_tutorial/homepage.dart';
import 'package:firebase_tutorial/loginpage.dart';
import 'package:firebase_tutorial/providers/google_sign_in.dart';
import 'package:firebase_tutorial/signuppage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}




class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  
 

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (context)=> GoogleSignInProvider(),
      child: MaterialApp(
        home: HomePage(),
        routes: <String, WidgetBuilder>{
          '/landingpage': (BuildContext context) => MyApp(),
          '/signup': (BuildContext context) => SignupPage(),
          '/homepage': (BuildContext context)=> HomePage(),
        },
      ),
    );
  }
}