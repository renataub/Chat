import 'package:flutter/material.dart';
import '../components/my_button.dart';
import '../components/my_textfeild.dart';
import '../services/auth/auth_services.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget{
  const RegisterPage();

  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final authService = AuthService();

  void register() async{
    if(passwordController.text == confirmPasswordController.text){
      try{
        await authService.signUpWithEmailPassword(
          emailController.text,
          passwordController.text,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage()
          ),
        );
      } catch(e){
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.surface,
            title: Text(e.toString()),
          ),
        );
      }
    } else{
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.surface,
            title: Text("passwords don't match"),
          ),
        );
    }

  }

  void navigatorToLogin(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage()
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
                Text("Let's create an account for you",
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
                MyTextfeild(
                  controller: confirmPasswordController,
                  hintText: "Confirm Password",
                  obscureText: true,
                ),                       
                SizedBox(height: 25),
                MyButton(
                  onTap: register,
                  text: "Sign Up",
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already a member?",
                      style: TextStyle(color: Theme.of(context).colorScheme.primary),
                    ),
                    SizedBox(width: 4),
                    GestureDetector(
                      onTap: navigatorToLogin,
                      child: Text("Login now",
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