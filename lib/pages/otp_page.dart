
import 'package:e_commerce_user/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../auth_services/auth_services.dart';
import '../utility/widgets/show_loading.dart';

class OtpPage extends StatefulWidget {
  static const routeName ="otp-page";
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

TextEditingController codeController = TextEditingController();

class _OtpPageState extends State<OtpPage> {
  List list = [];
  String? vid;
  String? phoneNumber;
  @override
  void didChangeDependencies() {
    list = ModalRoute.of(context)!.settings.arguments as List;
    phoneNumber = list[0];
    vid = list[1];
    super.didChangeDependencies();
  }
  @override
  void dispose() {

    super.dispose();
  }
  bool _isLoading = false;

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
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          Image.asset(
            "assets/images/veryfi.jpg",
            height: 300,
            width: double.infinity,
            fit: BoxFit.fitHeight,
          ),
          const Text(
            "Verification number",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                wordSpacing: 2,
                fontStyle: FontStyle.normal),
          ),
          SizedBox(height: 10,),
          Text("Enter your 6 digit otp code numbers",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey),),

          SizedBox(height: 40,),





          PinCodeTextField(


            appContext: context,
            length: 6,
            obscureText: false,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 45,
                inactiveFillColor: Colors.white70,
                activeFillColor: Colors.white70,
                inactiveColor: Colors.green,
                selectedColor: Colors.green,
                selectedFillColor: Colors.white70
            ),
            animationDuration: Duration(milliseconds: 300),

            enableActiveFill: true,

            controller: codeController,
            onCompleted: (v) {

            },
            onChanged: (value) {

              setState(() {
                // currentText = value;
              });
            },
            beforeTextPaste: (text) {
              print("Allowing to paste $text");
              return true;
            },
          ),
          _isLoading? ShowLoading(): SizedBox(height: 70,),

          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 80, vertical: 0),
            child: ElevatedButton(
                onPressed: (){
                  setState(() {
                    _isLoading = true;
                  });
                  final PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: vid!, smsCode: codeController.text);
                  FirebaseAuth.instance.signInWithCredential(credential).then((userCredential) {
                    if(userCredential.user != null){
                      AuthService.deleteCurrentUser().then((value) => Navigator.pushReplacementNamed(context, RegistrationPage.routeName, arguments: phoneNumber));

                    }

                  });
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)))),
                child: Text(
                  "VERIFY",
                  style: TextStyle(fontSize: 16),
                )),
          ),


        ],
      ),
    );
  }

}
