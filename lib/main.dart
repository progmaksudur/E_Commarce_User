import 'package:e_commerce_user/pages/cart_page.dart';
import 'package:e_commerce_user/pages/check_outpage.dart';
import 'package:e_commerce_user/pages/launcher_page.dart';
import 'package:e_commerce_user/pages/login_page.dart';
import 'package:e_commerce_user/pages/otp_page.dart';
import 'package:e_commerce_user/pages/phone_verification.dart';
import 'package:e_commerce_user/pages/product_details_page.dart';
import 'package:e_commerce_user/pages/product_page.dart';
import 'package:e_commerce_user/pages/register_page.dart';
import 'package:e_commerce_user/pages/user_profile_page.dart';
import 'package:e_commerce_user/provider/cart_provider.dart';
import 'package:e_commerce_user/provider/order_provider.dart';
import 'package:e_commerce_user/provider/product_provider.dart';
import 'package:e_commerce_user/provider/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => ProductProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => OrderProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Map<int, Color> pokeballRedSwatch = {
      50: const Color.fromARGB(255, 246, 188, 171),
      100: const Color.fromARGB(255, 239, 153, 130),
      200: const Color.fromARGB(255, 239, 131, 103),
      300: const Color.fromARGB(255, 230, 66, 25),
      400: const Color.fromARGB(255, 230, 66, 25),
      500: const Color.fromARGB(255, 230, 66, 25),
      600: const Color.fromARGB(255, 230, 66, 25),
      700: const Color.fromARGB(255, 230, 66, 25),
      800: const Color.fromARGB(255, 230, 66, 25),
      900: const Color.fromARGB(255, 230, 66, 25),
    };
    MaterialColor appColor = MaterialColor(0xffe64219, pokeballRedSwatch);
    return  MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: appColor,
      ),
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName: (context) => const LauncherPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        ProductPage.routeName: (context) => const ProductPage(),
        ProductDetailsPage.routeName: (context) => ProductDetailsPage(),
        PhoneVerification.routeName: (context) =>   PhoneVerification(),
        OtpPage.routeName: (context) => const  OtpPage(),
        RegistrationPage.routeName: (context) => const  RegistrationPage(),
        UserProfilePage.routeName: (context) => const  UserProfilePage(),
        CartPage.routeName: (context) => const  CartPage(),
        CheckoutPage.routeName: (context) => const  CheckoutPage(),
      },
    );
  }
}

