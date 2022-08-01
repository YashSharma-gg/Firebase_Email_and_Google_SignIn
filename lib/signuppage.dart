import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_tutorial/main.dart';
import 'package:firebase_tutorial/services/signin.dart';
import 'package:flutter/material.dart';

import 'services/usermanagement.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Email form field
              TextFormField(
                decoration: InputDecoration(hintText: 'Email'),
                controller: _emailController,
                textInputAction: TextInputAction.next,

                // Validates the email
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Enter Valid Email'
                        : null,
              ),
              SizedBox(height: 15),

              // Password form field
              TextFormField(
                  decoration: InputDecoration(hintText: 'Password'),
                  controller: _passwordController,
                  obscureText: true,
                  textInputAction: TextInputAction.done,

                  // validates password
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (password) =>
                      password != null && password.length < 6
                          ? 'Enter min. of 6 characters'
                          : null),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  signUp();
                },
                child: Text('Sign Up'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange[400],
                  textStyle: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future signUp() async {
    

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
          .then((signedInUser) {
        UserManagement().storeNewUser(signedInUser, context);
      });
    } on FirebaseAuthException catch (e) {
      print(e);
    }

 
  }
}
