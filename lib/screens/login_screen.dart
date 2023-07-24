// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:news_app/providers/auth.dart';
import 'package:news_app/widgets/bottom_nav_bar.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:testproject/src/mixins/login_mixin.dart';
// import 'package:news_app/screens/login_screen.dart';
import 'package:news_app/screens/login_mixin.dart';
// import 'package:news_app/screens/signup_mixin.dart';

// import '../ressources/colors.dart';
import 'package:news_app/screens/signup_screen.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with LoginMixin {
  //Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // isObscure boolean to show password
  bool isObscure = true;
  // boolean for animation on tapping the signup button
  late bool isLoading;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 23, 41),
      body: Padding(
        padding: const EdgeInsets.only(left: 32.0, top: 90, right: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Text(
                "Log In",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  Column(
                    children: [
                      textField(),
                      passwordWidget(),
                      loginButton(context, size),
                      doesntHaveAccountWidget(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row doesntHaveAccountWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Vous n'avez pas de compte ?",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageTransition(
                type: PageTransitionType.leftToRight,
                child: const SignUpScreen(),
                duration: const Duration(milliseconds: 500),
              ),
            );
          },
          child: const Text(
            'Inscrivez-vous',
            style: TextStyle(color: Colors.blue, fontSize: 16),
          ),
        )
      ],
    );
  }

  Widget loginButton(BuildContext context, Size size) {
    final auth = Provider.of<Auth>(context);
    return GestureDetector(
      onTap: () async {
        print('hello');
        if (formKey.currentState!.validate()) {
          String email = emailController.text;
          String password = passwordController.text;
          // setState(() {
          //   isLoading = true;
          // });
          var response = await auth.logIn(email, password);
          print(response);
          if (response) {
            Navigator.of(context).pushNamed(BottomNavBar.routeName);
            // setState(() {
            //   isLoading = false;
            // });
          } else {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Login Failed'),
                content: const Text('Something went wrong'),
                actions: [
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  ),
                ],
              ),
            );
          }
        }
      },
      child: Container(
        height: size.height * 0.065,
        margin: const EdgeInsets.only(top: 16, bottom: 10),
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : const Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }

  Widget textField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
          controller: emailController,
          // controller: _textEditingController,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.transparent,
              label: const Text('Email'),
              labelStyle: const TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              prefixIcon: const Icon(Icons.email),
              prefixIconColor: Colors.white),
          cursorColor: Colors.white,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(color: Colors.white),
          validator: emailValidator),
    );
  }

  Padding passwordWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
          controller: passwordController,
          obscureText: isObscure,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.transparent,
              label: const Text("Mot de passe"),
              labelStyle: const TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              prefixIcon: const Icon(Icons.lock),
              prefixIconColor: Colors.white,
              suffixIcon: IconButton(
                icon: Icon(
                  isObscure ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
              )),
          cursorColor: Colors.white,
          keyboardType: TextInputType.visiblePassword,
          style: const TextStyle(color: Colors.white),
          validator: passwordValidator),
    );
  }
}
