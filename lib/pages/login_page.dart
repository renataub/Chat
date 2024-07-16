import 'package:chat/pages/register_page.dart';
import 'package:chat/services/auth/auth_services.dart';
import 'package:flutter/material.dart';
import '../components/my_button.dart';
import '../components/my_textfeild.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget{
  const LoginPage();

  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    final authService = AuthService();

    try{
      await authService.signInWithEmailPassword(
        emailController.text,
        passwordController.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch(e) {
      String errorMessage = authService.getErrorMessage(e.toString());
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(errorMessage),
        ),
      );
    }
  }

  void navigatorToRegister(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterPage()
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Image.asset('lib/images/message.png',
                  height: 100,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(height: 50),
                Text("Welcome back!",
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(height: 50),
                MyTextfeild(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),
                SizedBox(height: 10),
                MyTextfeild(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: Text('Forgot Password?',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                MyButton(
                  onTap: login,
                  text: "Login",
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a member?",
                      style: TextStyle(color: Theme.of(context).colorScheme.primary),
                    ),
                    SizedBox(width: 4),
                    GestureDetector(
                      onTap: navigatorToRegister,
                      child: Text("Register now",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}