import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../database/db_helper.dart';
import '../model/user_model.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static User? get user => _auth.currentUser;

  static Future<bool> login(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    return credential.user != null;
  }

  static Future<void> register(
      String name,
      String mobile,
      String email,
      String password,
      ) async {
    final credential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    UserModel userModel = UserModel(
        uid: credential.user!.uid,
        email: email,
        name: name,

        mobile: mobile,
        userCreationTime:
        Timestamp.fromDate(credential.user!.metadata.creationTime!));
    return DBHelper.addUser(userModel);
  }

  static Future<void> addUser(UserModel userModel) => DBHelper.addUser(userModel);

  static Future<void> deleteCurrentUser() => _auth.currentUser!.delete();

  static Future<void> logout() => _auth.signOut();
}
