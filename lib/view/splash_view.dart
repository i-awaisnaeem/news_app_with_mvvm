import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_flutter/view_view_model/services/splash_services.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 10), (){
      SplashService.checkAuthStatus(context);
    });
  }

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.sizeOf(context).height *1;
    final width = MediaQuery.sizeOf(context).width *1;

    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/splash_pic.jpg',
            fit: BoxFit.cover,
            width: width * .8,
            height: height *.5,),
            SizedBox(height: height* .04,),
            Text('TOP HEADLINES' ,
            style: GoogleFonts.anton(
              letterSpacing: .6,
              color: Colors.grey.shade700
            ),),
        SizedBox(height: height * .04,),
      const SpinKitChasingDots(
        color: Colors.blue,
          size: 40,
      )

          ],
        ),
      ),
    );
  }
}
