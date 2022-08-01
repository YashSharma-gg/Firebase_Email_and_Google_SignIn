import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_tutorial/providers/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();


  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(25),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: 'Email'),
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email)=> email != null && !EmailValidator.validate(email) ? 'Enter Valid Email': null,
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(hintText: 'Password'),
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Login();
                  },
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange[400],
                    textStyle: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),

                Text('OR', style: TextStyle(fontSize: 20, color: Colors.grey[600]),),

                SizedBox(
                  height: 15,
                ),

                ElevatedButton.icon(
                  onPressed: ()async{
                    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                    provider.googleLogin();

                  },
                  icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    minimumSize: Size(300, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                  ),
                  label: Text('Continue with Google', ),
                  ),
                

                SizedBox(
                  height: 15,
                ),
                Text('Don\'t  have an account??'),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/signup');
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
      ),
    );
  }

Future Login()async{
  try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim()).then((value) => Navigator.of(context).pushNamed('/homepage'));
  } on FirebaseAuthException catch(e){print(e);}
}

}
