import 'package:chatapp_prototype/services/authservice.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('signout'),
          onPressed: (){
            AuthService().signOut();
          },
        ),
      ),
    );
  }
}