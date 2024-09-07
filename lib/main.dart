import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:news_app_flutter/view_view_model/auth_view_view_model.dart';
import 'firebase_options.dart'; // Make sure this is the correct path
import 'package:news_app_flutter/utils/routes/routes.dart';
import 'package:news_app_flutter/utils/routes/routes_name.dart';
import 'package:news_app_flutter/view_view_model/category_view_view_model.dart';
import 'package:news_app_flutter/view_view_model/news_view_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import dotenv for environment variables

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter bindings are initialized

  // Load environment variables (ensure your .env file is properly set up)
  await dotenv.load();

  // Initialize Firebase with secure Firebase options from environment variables
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Use secure options
  );

  runApp(const MyApp()); // Run the app after Firebase initialization
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewViewModel()), // AuthViewModel
        ChangeNotifierProvider(create: (_) => NewsViewViewModel()), // NewsViewModel
        ChangeNotifierProvider(create: (_) => CategoryViewViewModel()), // CategoryViewModel
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Disable debug banner
        title: 'News App',
        initialRoute: RouteName.SplashView, // Set initial route to SplashView
        onGenerateRoute: Routes.generateRoute, // Route generation logic
      ),
    );
  }
}
