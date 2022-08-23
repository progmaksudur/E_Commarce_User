
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


import '../auth_services/auth_services.dart';

import '../model/user_model.dart';
import '../provider/user_provider.dart';


class UserProfilePage extends StatefulWidget {
  static const routeName = "user-profile-page";
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final txtContoller = TextEditingController();
  @override
  void dispose() {
    txtContoller.dispose();
    super.dispose();
  }
  late UserProvider provider;
  @override
  void didChangeDependencies() {
    provider = Provider.of<UserProvider>(context,listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My profile"),
      ),

      body: Center(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: provider.getUserByUid(AuthService.user!.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userModel = UserModel.fromMap(snapshot.data!.data()!);

              return ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: userModel.image == null
                        ? Image.asset(
                      "assets/images/person.png",
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        userModel.image!,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  TextButton.icon(
                      onPressed: updateImage,
                      icon: Icon(Icons.camera_alt),
                      label: Text("Change image")),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: Text(userModel.name == null
                        ? "No Display Name"
                        : userModel.name!),
                    trailing: IconButton(
                        onPressed: () {
                          showInputDialog("Display Name", userModel.name,
                                  (value) async {
                                // provider.updateProfile(
                                //     AuthService.user!.uid, {"name": value});
                                // await AuthService.updateDisplayName(value);
                              });
                        },
                        icon: Icon(Icons.edit)),
                  ),
                  ListTile(
                    title: Text(userModel.mobile == null
                        ? "No Mobile number"
                        : userModel.mobile!),
                    trailing:
                    IconButton(onPressed: () {
                      showInputDialog("Mobile Number", userModel.mobile,
                              (value) {
                            provider.updateProfile(
                                AuthService.user!.uid, {"mobile": value});
                          });
                    }, icon: Icon(Icons.edit)),
                  ),
                  ListTile(
                    title: Text(userModel.email == null
                        ? "No email address"
                        : userModel.email),
                    trailing:
                    IconButton(onPressed: () {
                      showInputDialog("Email Address", userModel.email,
                              (value) {
                            provider.updateProfile(
                                AuthService.user!.uid, {"email": value});
                          });
                    }, icon: Icon(Icons.edit)),
                  ),
                ],
              );
            }
            if (snapshot.hasError) {
              return const Text("Failed to fatch data");
            }
            return const CircularProgressIndicator();
          },
        ),

      ),
    );
  }

  void updateImage() async {
    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 75);
    if (xFile != null) {
      try {
        final downloadurl =
        await Provider.of<UserProvider>(context, listen: false)
            .updateImage(xFile);
        await Provider.of<UserProvider>(context, listen: false)
            .updateProfile(AuthService.user!.uid, {"image": downloadurl});
        // await AuthService.updateDisplayImage(downloadurl);
      } catch (e) {
        rethrow;
      }
    }
  }

  showInputDialog(String title, String? value, Function(String) onSaved) {
    txtContoller.text = value ?? "";
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: txtContoller,
              decoration: InputDecoration(hintText: "Enter $title"),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel")),
            TextButton(
                onPressed: () {
                  onSaved(txtContoller.text);
                  Navigator.pop(context);
                },
                child: Text("Update"))
          ],
        ));
  }
}