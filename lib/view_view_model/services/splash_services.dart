// services/splash_service.dart

import 'package:flutter/material.dart';
import 'package:news_app_flutter/view_view_model/auth_view_view_model.dart';
import 'package:provider/provider.dart';
import '../../utils/routes/routes_name.dart';


class SplashService {
  static Future<void> checkAuthStatus(BuildContext context) async {
    final authViewModel = Provider.of<AuthViewViewModel>(context, listen: false);
    bool isLoggedIn = await authViewModel.isUserLoggedIn();

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, RouteName.HomeView);
    } else {
      Navigator.pushReplacementNamed(context, RouteName.SigninView);
    }
  }
}
