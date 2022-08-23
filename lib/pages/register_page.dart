// ignore_for_file: prefer_const_constructors

import 'package:e_commerce_user/pages/phone_verification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../auth_services/auth_services.dart';
import '../utility/widgets/show_loading.dart';
import 'launcher_page.dart';

class RegistrationPage extends StatefulWidget {
  static const routeName = "registration-page";
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final namedController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void didChangeDependencies() {
    final phone = ModalRoute.of(context)!.settings.arguments as String;
    phoneController.text = phone;
    super.didChangeDependencies();
  }

  final formKey = GlobalKey<FormState>();
  String _errorMessage = "";
  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    namedController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Form(
              key: formKey,
              child: ListView(
                padding: EdgeInsets.all(15),
                shrinkWrap: true,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    "assets/images/login.jpg",
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: namedController,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xffe6e6e6),
                        contentPadding: const EdgeInsets.only(left: 10),
                        focusColor: Colors.white,
                        prefixIcon: const Icon(
                          Icons.account_circle,
                        ),
                        hintText: "Enter your full name",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.normal),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field must not be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  TextFormField(
                    controller: phoneController,
                    enabled: false,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xffe6e6e6),
                        contentPadding: const EdgeInsets.only(left: 10),
                        focusColor: Colors.white,
                        prefixIcon: const Icon(
                          Icons.phone,
                        ),
                        hintText: "Enter your phone number",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.normal),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field must not be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  // todo This is email textField section
                  TextFormField(
                    controller: emailController,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xffe6e6e6),
                        contentPadding: const EdgeInsets.only(left: 10),
                        focusColor: Colors.white,
                        prefixIcon: const Icon(
                          Icons.email,
                        ),
                        hintText: "Enter your email address",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.normal),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field must not be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  // todo this is password textField section
                  TextFormField(
                    obscureText: _isObscure,
                    controller: passwordController,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffe6e6e6),
                        contentPadding: EdgeInsets.only(left: 10),
                        focusColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.lock,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                        hintText: "Enter your password",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.normal),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field must not be empty';
                      } else {
                        return null;
                      }
                    },
                  ),

                  _isLoading
                      ? ShowLoading()
                      : Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 15),
                    child: ElevatedButton(
                        onPressed: _chechValidet,
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                        child: Text(
                          "SignUp",
                          style: TextStyle(fontSize: 16),
                        )),
                  ),

                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'You have an account? ',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                          text: 'Login',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(
                                  context, PhoneVerification.routeName);
                            }),
                    ]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(),
                  Text(
                    "Or signing with",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        letterSpacing: 1,
                        wordSpacing: 1),
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {},
                          child: Image.asset(
                            "assets/images/google.png",
                            height: 30,
                            width: 30,
                            fit: BoxFit.cover,
                          )),
                      SizedBox(
                        width: 15,
                      ),
                      InkWell(
                          onTap: () {},
                          child: Image.asset(
                            "assets/images/facebook.png",
                            height: 30,
                            width: 30,
                            fit: BoxFit.cover,
                          ))
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }

  void _chechValidet() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {

        AuthService.register(
          namedController.text,
          phoneController.text,
          emailController.text,
          passwordController.text,
        ).then((value) => Navigator.pushNamedAndRemoveUntil(context, LauncherPage.routeName, (route) => false));

      } on FirebaseAuthException catch (e) {
        setState(() {
          setState(() {
            _isLoading = false;
          });
          _errorMessage = e.message!;
        });
      }
    }
  }
}
