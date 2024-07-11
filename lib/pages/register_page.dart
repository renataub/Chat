import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget{
  const RegisterPage();

  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
    );
  }
}