import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class UserManagement {
  storeNewUser(UserCredential user,context) {
    var curUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('/users')
        .add({
          'email' : curUser?.email,
          'uid': curUser?.uid
        })
        .then((value) {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed('/homepage');

        })
        .catchError((e) {
          print(e);
        });
  }
}
