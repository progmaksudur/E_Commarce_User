
import 'package:e_commerce_user/pages/otp_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utility/widgets/show_loading.dart';



class PhoneVerification extends StatefulWidget {
  static const routeName = "phone-verification";
  PhoneVerification({Key? key}) : super(key: key);

  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  final phoneController = TextEditingController();

  bool _isLoading = false;
  String vid = "";

  final formKey = GlobalKey<FormState>();
  bool isLoading=false;

  String? _errorText = "";

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme:  const IconThemeData(


            color: Colors.black

        ),
      ),
      body: Center(
        child: Form(
            key: formKey,
            child: ListView(
              padding: EdgeInsets.all(15),
              shrinkWrap: true,
              children: [


                Image.asset(
                  "assets/images/phone.jpg",
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.fitHeight,
                ),
                SizedBox(height: 40,),
                const Text(
                  "Enter your phone number",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      wordSpacing: 2,
                      fontStyle: FontStyle.normal),
                ),
                SizedBox(height: 10,),
                Text("We will send you the 6 digit verification code",textAlign: TextAlign.center,),
                SizedBox(height: 40,),


                // todo This is phone textField section
                TextFormField(
                  controller: phoneController.. text="+880",
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
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 80, vertical: 15),
                  child: ElevatedButton(
                      onPressed: (){
                        _veryfay();
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)))),
                      child: Text(
                        "SEND",
                        style: TextStyle(fontSize: 16),
                      )),
                ),
                _isLoading? ShowLoading() :
                Text(_errorText.toString(), style: TextStyle(color: Colors.red),),
              ],
            )),
      ),
    );
  }

  _veryfay() async {
    setState(() {
      _isLoading = true;
    });
    final phone = phoneController.text;

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) {
        print("complete");
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() {
          _errorText = "Phone verification failed. please try again!";
          _isLoading = false;
        });
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          codeController.text = "";
          vid = verificationId;
        });



        Navigator.pushNamed(context, OtpPage.routeName, arguments: [phone, vid]);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );

  }
}
