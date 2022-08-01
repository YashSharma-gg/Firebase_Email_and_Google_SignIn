import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_tutorial/loginpage.dart';
import 'package:firebase_tutorial/providers/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  

  @override
  State<HomePage> createState() => _HomePageState();
  
}

class _HomePageState extends State<HomePage> {
  
  // @override
  // void initState() {
  //   super.initState();
  //   Firebase.initializeApp().whenComplete(() { 
  //     print("completed");
  //     setState(() {});
  //   });
  // }
  
  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(color: Colors.orange[400],),);
            }else if (snapshot.hasData){
              return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text('You are Logged In !!', style: TextStyle(color: Colors.green),),
            
                SizedBox(height: 20,),
            
                ElevatedButton(
                  onPressed: (){
                    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                    provider.logout().then((value){
                      Navigator.of(context).pushReplacementNamed('/landingpage');
                    }).catchError((e){print(e);});

                  },
                  child: Text('Log Out',),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green
                  )
                  )
              ]),
            );
            } else if (snapshot.hasError){
              return Center(child: Text('Something went wrong! '));
            }else {
              return LoginPage();
            }

            
          }
        ),
      ),
    );

  }
}