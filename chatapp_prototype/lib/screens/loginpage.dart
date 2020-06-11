import 'dart:ffi';

import 'package:chatapp_prototype/services/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FormKey = new GlobalKey<FormState>();
  String phoneNo,verificatioId, smscode;
  bool codeSent = false ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form
      (key: FormKey,
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
           Padding(
             padding:EdgeInsets.only(left: 25.0 ,right: 25.0),
             child: TextFormField(
               keyboardType: TextInputType.phone,
               decoration: InputDecoration(hintText: 'Enter phone number'),
               onChanged: (val){
                 setState(() {
                   this.phoneNo =val ;
                 });
               },
             ),
           ),
            codeSent ? Padding(
             padding:EdgeInsets.only(left: 25.0 ,right: 25.0),
             child: TextFormField(
               keyboardType: TextInputType.phone,
               decoration: InputDecoration(hintText: 'Enter OTP'),
               onChanged: (val){
                 setState(() {
                   this.smscode =val ;
                 });
               },
             ),
           ):Container(),
           Padding(
             padding: EdgeInsets.only(left: 25.0 ,right: 25.0),
             child: RaisedButton(
               child: Center(
                  child:codeSent ? Text('login') : Text('verify'),
               ),
               onPressed:(){
                codeSent ? AuthService().signInWithOTP(smscode, verificatioId):verifyPhone(phoneNo);
               }
             ),
            )
         ],
       ),
      ),
      
    );
  }
  Future<Void> verifyPhone (phoneNo) async{
    final PhoneVerificationCompleted verified = (AuthCredential authResult){
      AuthService().signIn(authResult);
    };
    final PhoneVerificationFailed verificationFaild = (AuthException authException){
       print('${authException.message}');
    };
    final PhoneCodeSent smsSent = (String verId ,[int forceResend]){
      this.verificatioId = verId ;
      setState(() {
        this.codeSent =true;
      });
    };
    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId){
       this.verificatioId = verId ;
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verified, 
      verificationFailed: verificationFaild, 
      codeSent: smsSent, 
      codeAutoRetrievalTimeout: autoTimeout);
  }
}