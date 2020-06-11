import 'package:chatapp_prototype/screens/loginpage.dart';
import 'package:chatapp_prototype/screens/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  // handels Auth
  handleAuth(){
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context , snapshot){
        if(snapshot.hasData){
          return DashboardPage();
        }
        else{
          return LoginPage();
        }
      },
    );
  }

  //signOut 
  signOut(){
    FirebaseAuth.instance.signOut();
  }

  //signIn
  signIn(AuthCredential authcreds){
    FirebaseAuth.instance.signInWithCredential(authcreds);
  }

  signInWithOTP(smsCode , verId){
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
      verificationId: verId, 
    smsCode: smsCode);
    signIn(authCreds);
  }
}
