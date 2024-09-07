import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app_flutter/view_view_model/auth_view_view_model.dart';
import 'package:provider/provider.dart';
import '../resources/components/round_button.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';


class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  ValueNotifier<bool> _obsecureText = ValueNotifier<bool>(true);

  @override
  void dispose() {
    // TODO: implement dispose

    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _obsecureText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    final authViewViewModel = Provider.of<AuthViewViewModel>(context);

    return Scaffold(
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(children: [
                    Text('News App',
                      style: GoogleFonts.poppins(
                          fontSize: 48,
                          fontWeight: FontWeight.w700
                      ),),
                    SizedBox(height: height * .01,),
                    Text('Know what happening near you',
                      style: GoogleFonts.poppins(),)
                  ],),
                  SizedBox(height: height * .06,),
                  Text('Sign up',
                    style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w500
                    ),),
                  SizedBox(height: height * .06,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    focusNode: emailFocusNode,
                    controller: emailController,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r"\s")), // Prevent spaces
                    ],
                    decoration:  InputDecoration(
                      hintText: 'email',
                      hintStyle: GoogleFonts.poppins() ,
                      prefixIcon: Icon(Icons.alternate_email_outlined),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black), // Change the color here
                      ),
                    ),
                    onFieldSubmitted: (value) {
                      Utils.fieldFocusChange(
                          context, emailFocusNode, passwordFocusNode);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ValueListenableBuilder(
                      valueListenable: _obsecureText,
                      builder: (context, value, child) {
                        return TextFormField(
                          controller: passwordController,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r"\s")), // Prevent spaces
                          ],
                          focusNode: passwordFocusNode,
                          obscureText: _obsecureText.value,
                          obscuringCharacter: '*',
                          decoration: InputDecoration(
                            hintText: 'password',
                            hintStyle: GoogleFonts.poppins() ,
                            prefixIcon: const Icon(Icons.lock_outline),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black), // Change the color here
                            ),
                            suffixIcon: InkWell(
                                onTap: () {
                                  _obsecureText.value = !_obsecureText.value;
                                },
                                child: Icon(_obsecureText.value
                                    ? Icons.visibility
                                    : Icons.visibility_off_outlined)),
                          ),
                        );
                      }),
                  SizedBox(
                    height: height * .06,
                  ),
                  RoundButton(
                    title: 'Sign up',
                    loading: authViewViewModel.loading,
                    onPress: () {
                      if (emailController.text.isEmpty) {
                        Utils.flushBarErrorMessage('Please Entre Email', context);
                      } else if (passwordController.text.isEmpty) {
                        Utils.flushBarErrorMessage('Please Entre Password', context);
                      } else if (passwordController.text.length < 6) {
                        Utils.flushBarErrorMessage(
                            'Password should be greater than 6 characters', context);
                      } else {
                        String email = emailController.text;
                        String password = passwordController.text;
                        authViewViewModel.signUpWithEmailPassword(email,password, context);
                      }
                    },
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children : [
                        Text('Already have an account?',
                          style: GoogleFonts.poppins(
                              color: Colors.black
                          ),),
                        SizedBox( width: width * 0.02,),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, RouteName.SigninView);
                          },
                          child:  Text('Sign in',
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600
                              ) ),
                        ),]
                  )
                ],
              ),
            )));
  }
}
