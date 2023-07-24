import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'package:news_app/providers/auth.dart';
import 'package:news_app/screens/home_page.dart';
// import 'package:news/src/mixins/signup_mixin.dart';
// import 'package:testproject/src/ressources/colors.dart';

import 'package:page_transition/page_transition.dart';
import 'package:news_app/screens/signup_mixin.dart';
import 'package:provider/provider.dart';
// import 'package:news_app/screens/login_screen.dart';
import '../widgets/bottom_nav_bar.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static String routeName = '/signUpScreen';
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with SignupMixin {
  //Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //TextEditing Controller
  // final TextEditingController birthdayController = TextEditingController();
  // isObscure boolean to show password
  bool isObscure = true;
  // for confirmation field
  bool isObscureConfirmation = true;
  // boolean for animation on tapping the signup button
  late bool isLoading;

  //Controllers
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  // TextEditingController numeroCompteController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmationController = TextEditingController();

  @override
  void initState() {
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final heightSize = size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 23, 41),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0, top: 90, right: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Text(
                  "Sign Up",
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
                          // textField(nomController, 'Nom', TextInputType.text,
                          //     Icons.person, nomValidator, heightSize),
                          // textField(
                          //     prenomController,
                          //     'Prénom',
                          //     TextInputType.text,
                          //     Icons.person,
                          //     prenomValidator,
                          //     heightSize),
                          // textField(
                          //     numeroCompteController,
                          //     'Numéro compte chèque',
                          //     TextInputType.number,  
                          //     Icons.account_balance_wallet,
                          //     accountNumberValidator,
                          //     heightSize),
                          textField(
                              emailController,
                              'Email',
                              TextInputType.emailAddress,
                              Icons.email,
                              emailValidator,
                              heightSize),
                          passwordWidget(),
                          passwordConfirmationWidget(),
                          signupButton(size),
                          hasAccountWidget()
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Row hasAccountWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Avez-vous déjà un compte ?",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: const LoginScreen(),
                duration: const Duration(milliseconds: 500),
              ),
            );
          },
          child: const Text(
            'Se connecter',
            style: TextStyle(color: Colors.blue, fontSize: 16),
          ),
        )
      ],
    );
  }

  Widget signupButton(Size size) {
    return GestureDetector(
      onTap: () async {
        if (formKey.currentState!.validate()) {
          String email = emailController.text;
          String password = passwordController.text;

          // String confirmation = confirmationController.text;

          var auth = Provider.of<Auth>(context, listen: false);

          var response = await auth.signUp(email, password);
          // var responsBody = json.decode(response.body);
          // Auth.email = email;
          // Auth.userId = response['user_id'];

          print(response);

          if (response) {
            Navigator.pushNamed(context, BottomNavBar.routeName);
          } else {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Signup Failed'),
                content: const Text('Email already exists, please try again.'),
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
                  "Sign Up",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
        ),
      ),
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

  Padding passwordConfirmationWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
          controller: confirmationController,
          obscureText: isObscureConfirmation,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.transparent,
              label: const Text("Confirmation"),
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
                  isObscureConfirmation
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    isObscureConfirmation = !isObscureConfirmation;
                  });
                },
              )),
          cursorColor: Colors.white,
          keyboardType: TextInputType.visiblePassword,
          style: const TextStyle(color: Colors.white),
          validator: (value) => passwordConfirmationValidator(
              passwordController.text, confirmationController.text)),
    );
  }

  Widget textField(controller, String labelText, keyboardType,
      IconData leadingIcon, String? Function(String?)? validator, height) {
    return Container(
      // height: 70,
      // TODO: fix textfield Size
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
          textCapitalization: TextCapitalization.words,
          controller: controller,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.transparent,
              label: Text(labelText),
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
              prefixIcon: Icon(leadingIcon),
              prefixIconColor: Colors.white),
          cursorColor: Colors.white,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white),
          validator: validator),
    );
  }
}
