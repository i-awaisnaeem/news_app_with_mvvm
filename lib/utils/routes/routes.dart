import 'package:flutter/material.dart';
import 'package:news_app_flutter/utils/routes/routes_name.dart';
import 'package:news_app_flutter/view/category_view.dart';
import 'package:news_app_flutter/view/news_datails_view.dart';
import 'package:news_app_flutter/view/signin_view.dart';
import 'package:news_app_flutter/view/signup_view.dart';
import 'package:news_app_flutter/view/splash_view.dart';
import 'package:news_app_flutter/view/home_view.dart';

class Routes{

  static Route<dynamic> generateRoute(RouteSettings settings){

    switch (settings.name){

      case RouteName.SplashView:
        return MaterialPageRoute(builder: (context)=> SplashView());

      case RouteName.SigninView:
        return MaterialPageRoute(builder: (context)=> SigninView());

      case RouteName.SignupView:
        return MaterialPageRoute(builder: (context) => SignupView());
        
      case RouteName.HomeView:
        return MaterialPageRoute(builder: (context) => HomeView());

      case RouteName.CategoryView:
        return MaterialPageRoute(builder: (context) => CategoryView());

      case RouteName.NewsDetailsView:
        final Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (context) => NewsDatailsView(
            newsImage: arguments['newsImage'],
            newsDate: arguments['newsDate'],
            newsTitle: arguments['newsTitle'],
            description: arguments['description'],
            source: arguments['source'],
            author: arguments['author'],
            content: arguments['content'],

        ));

      default:
        return MaterialPageRoute(builder: (context){
          return const Scaffold(
            body: Center(
              child: Text('No Route Found'),
            ),
          );
        });

    }

  }

}