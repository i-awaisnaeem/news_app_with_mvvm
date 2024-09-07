import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:news_app_flutter/view_view_model/auth_view_view_model.dart';
import 'firebase_options.dart'; // Ensure this import matches the location of your firebase_options.dart file
import 'package:news_app_flutter/utils/routes/routes.dart';
import 'package:news_app_flutter/utils/routes/routes_name.dart';
import 'package:news_app_flutter/view_view_model/category_view_view_model.dart';
import 'package:news_app_flutter/view_view_model/news_view_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter bindings are initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Initialize Firebase

  runApp(const MyApp()); // Run the app after Firebase initialization
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewViewModel()),
        ChangeNotifierProvider(create: (_) => NewsViewViewModel()),
        ChangeNotifierProvider(create: (_) => CategoryViewViewModel())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News App',
        initialRoute: RouteName.SplashView,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
