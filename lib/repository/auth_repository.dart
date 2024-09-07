import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel> loginWithEmailPassword(String email, String password) async {
    try {
      // Log in the user with Firebase Auth
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Convert Firebase User to UserModel and return
     /* if (kDebugMode) {
        print('User logged in: ${userCredential.user!.email}');
      } */
      return UserModel.fromFirebaseUser(userCredential.user!);
    } catch (e) {
      throw e;  // Handle Firebase exceptions or custom error handling
    }
  }

  Future<UserModel> signUpWithEmailPassword(String email, String password) async {
    try {
      // Register a new user
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (kDebugMode) {
        print('User registered: ${userCredential.user!.email}');
      }
      return UserModel.fromFirebaseUser(userCredential.user!);
    } catch (e) {
      throw e;
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
     /* if (kDebugMode) {
        print('User logged out');
      } */
    } catch (e) {
      throw e;
    }
  }

  // Retrieve the current Firebase user if already logged in
  UserModel? getCurrentUser() {
    User? user = _auth.currentUser;
    if (user != null) {
      return UserModel.fromFirebaseUser(user);
    }
    return null;
  }
}
