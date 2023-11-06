import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_app/domain/firestore_user.dart';

final signupMainProvider = ChangeNotifierProvider((ref) => SignupMainModel());

class SignupMainModel extends ChangeNotifier {
  int counter = 0;
  User? currentUser;
  String email = "";
  String password = "";
  bool isObscure = true;

  Future<void> createFirestoreUser(
      {required BuildContext context, required String uid}) async {
    counter++;
    final Timestamp now = Timestamp.now();
    final FirestoreUser fireStoreUser = FirestoreUser(
        createdAt: now,
        updatedAt: now,
        email: email,
        userName: "Alice",
        uid: uid,
        userImageURL: "");
    final Map<String, dynamic> userData = fireStoreUser.toJson();
    await FirebaseFirestore.instance.collection('users').doc(uid).set(userData);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('ユーザーが作成できました')));
    notifyListeners();
  }

  Future<void> createUser({required BuildContext context}) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user = result.user;
      final String uid = user!.uid;
      await createFirestoreUser(context: context, uid: uid);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  void toggleIsObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }
}
