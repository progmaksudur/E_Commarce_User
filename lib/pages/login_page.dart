// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_user/pages/phone_verification.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../auth_services/auth_services.dart';
import '../model/user_model.dart';
import '../utility/widgets/show_loading.dart';
import 'launcher_page.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "login-page";
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  String _errorMessage = "";
  bool _isloading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                  const Text(
                    "Welcome User!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        wordSpacing: 2,
                        fontStyle: FontStyle.normal),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    "assets/images/login.jpg",
                    height: 230,
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                  ),
                  SizedBox(
                    height: 20,
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
                        hintText: "Enter your email",
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

                  Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "forget password?",
                          ))),
                  _isloading
                      ? ShowLoading()
                      : Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),

                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                    child: ElevatedButton(
                        onPressed: () {
                          _chechValidet();
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                        child: Text(
                          "LogIn",
                          style: TextStyle(fontSize: 16),
                        )),
                  ),

                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'You have no account? ',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                          text: ' Sign UP',
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
                    height: 15,
                  ),
                  Text(
                    "Or signing with",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        letterSpacing: 1,
                        wordSpacing: 1),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            signInWithGoogle().then((value) {
                              if (value.user != null) {
                                final userModel = UserModel(
                                  uid: value.user!.uid,
                                  email: value.user!.email!,
                                  image: value.user!.photoURL,
                                  name: value.user!.displayName ??
                                      "Name not available",
                                  mobile: value.user!.phoneNumber ??
                                      "Number not Available",
                                  userCreationTime: Timestamp.fromDate(
                                      value.user!.metadata.creationTime!),
                                );
                                AuthService.addUser(userModel).then((value) =>
                                    Navigator.pushReplacementNamed(
                                        context, LauncherPage.routeName));
                              }
                            }).catchError((error) {
                              setState(() {
                                _errorMessage = error.toString();
                              });
                            });
                          },
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
        _isloading = true;
      });

      try {
        final status = await AuthService.login(
            emailController.text, passwordController.text);
        if (status) {
          if (mounted) {
            Navigator.pushReplacementNamed(context, LauncherPage.routeName);
          }
        } else {
          AuthService.logout();
          setState(() {
            _isloading = false;
          });
          _errorMessage = "You are not admin";
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          setState(() {
            _isloading = false;
          });
          _errorMessage = e.message!;
        });
      }
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
