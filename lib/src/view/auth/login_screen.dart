// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../constants/auth_components/auth_screen_button.dart';
import '../../constants/auth_components/auth_textfield.dart';
import '../../constants/default_padding.dart';
import '../../constants/text_style.dart';
import '../../service/auth/auth_provider.dart';
import '../../service/auth/sign_in_with_google.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({
    super.key,
  });
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthProvider authProvider = AuthProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Padding(
          padding: kDefaultPadding,
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),

                  // logo
                  Image.asset(
                    "assets/icons/giyin_logo.png",
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),

                  const SizedBox(height: 24),

                  // wee happy to see you again
                  Text('We happy to see you again.', style: kMediumText),

                  const SizedBox(height: 25),

                  // username textfield
                  AuthTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  // password textfield
                  AuthTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  // forgot password?
                  buildForgotPasswordRow(context),

                  const SizedBox(height: 25),

                  AuthScreenButton(
                    buttonText: "Sign In",
                    onTap: () async {
                      String? error = await authProvider.signUserIn(
                          emailController.text, passwordController.text);
                      if (error != null) {
                        authProvider.showAlert(context, "Error", error);
                      } else {
                        Navigator.pushNamed(context, '/home');
                      }
                    },
                  ),

                  const SizedBox(height: 26),

                  // or continue with
                  buildOrContinueWithDivider(),

                  const SizedBox(height: 26),

                  // google + apple sign in buttons
                  buildLoginWithGoogleButton(context),

                  const SizedBox(height: 20),

                  // not a member? register now
                  buildRegisterNowRow(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row buildRegisterNowRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Not a member?',
          style: kSmallText,
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/register');
          },
          child: const Text(
            'Register now',
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ],
    );
  }

  Padding buildOrContinueWithDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 0.5,
              color: Colors.grey[400],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'Or continue with',
              style: kSmallText,
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 0.5,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Padding buildForgotPasswordRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/forgotPassword');
            },
            child: Text(
              'Forgot Password?',
              style: kSmallBlackText,
            ),
          ),
        ],
      ),
    );
  }

  Row buildLoginWithGoogleButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // google button
        GestureDetector(
          onTap: () => GoogleAuthService().signInWithGoogle(),
          child: Container(
              padding: const EdgeInsets.all(25),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/google.png",
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  const SizedBox(width: 20),
                  Text(
                    "Login with Google",
                    style: kSmallText,
                  )
                ],
              )),
        ),
      ],
    );
  }
}
