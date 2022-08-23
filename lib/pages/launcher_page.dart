

import 'package:e_commerce_user/pages/login_page.dart';
import 'package:e_commerce_user/pages/product_page.dart';
import 'package:flutter/material.dart';

import '../auth_services/auth_services.dart';



class LauncherPage extends StatefulWidget {
  static const routeName ="/";
  const LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {

    Future.delayed(Duration.zero,(){
      if(AuthService.user == null){
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }else{
        Navigator.pushReplacementNamed(context, ProductPage.routeName);
      }
    });


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: const CircularProgressIndicator(),
    );
  }
}

