// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:flutter/material.dart';

import '../../auth_services/auth_services.dart';
import '../../pages/launcher_page.dart';
import '../../pages/user_profile_page.dart';


class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                currentAccountPictureSize: Size.square(70),
                currentAccountPicture: AuthService.user!.photoURL == null
                    ? Image.asset("assets/images/person.png")
                    : ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(AuthService.user!.photoURL!)),
                accountName:
                Text(AuthService.user!.displayName ?? "Name not Available"),
                accountEmail:
                Text(AuthService.user!.email ?? "Email not Available")),
            Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, UserProfilePage.routeName);
                      },
                      leading: Icon(Icons.account_circle),
                      title: Text("Profile"),
                    ),
                    ListTile(
                      onTap: () {
                        AuthService.logout();

                        Navigator.pushReplacementNamed(context, LauncherPage.routeName);
                      },
                      leading: Icon(Icons.logout),
                      title: Text("LogOut"),
                    ),
                  ],
                ))
          ],
        ));
  }
}
