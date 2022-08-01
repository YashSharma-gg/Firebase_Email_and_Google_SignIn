
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/services/usermanagement.dart';
import 'package:flutter/widgets.dart';


Future Signin(email,password)async{
  BuildContext? context;
  await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim()).then((signedInUser){
    UserManagement().storeNewUser(signedInUser,context);
  }).catchError((e){print(e);});
}