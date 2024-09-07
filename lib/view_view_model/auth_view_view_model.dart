import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

class AuthViewViewModel with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginWithEmailPassword(String email, String password, BuildContext context) async {
    setLoading(true);
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Utils.flushBarSuccessMessage('Login Successfully', context);
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushNamed(context, RouteName.HomeView);
      });
    } catch (e) {
      Utils.flushBarErrorMessage(e.toString(), context);
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      setLoading(false);
    }
  }

  Future<void> signUpWithEmailPassword(String email, String password, BuildContext context) async {
    setLoading(true);
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      Utils.flushBarSuccessMessage('Signup Successfully', context);
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushNamed(context, RouteName.SigninView);
      });
    } catch (e) {
      Utils.flushBarErrorMessage(e.toString(), context);
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      setLoading(false);
    }
  }

  Future<void> logout(BuildContext context) async {
    setLoading(true);
    try {
      await _auth.signOut();
      Navigator.pushNamedAndRemoveUntil(context, RouteName.SigninView, (route) => false);
      Utils.flushBarSuccessMessage('Signed out Successfully', context);

    } catch (e) {
      Utils.flushBarErrorMessage(e.toString(), context);
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      setLoading(false);
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  bool isUserLoggedIn() {
    return _auth.currentUser != null;
  }
}
