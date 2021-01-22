import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:messenger_flutter/components/already_have_an_account_acheck.dart';
import 'package:messenger_flutter/components/rounded_button.dart';
import 'package:messenger_flutter/components/rounded_input_field.dart';
import 'package:messenger_flutter/components/rounded_password_field.dart';
import 'package:messenger_flutter/services/auth.dart';
import 'package:messenger_flutter/views/SignIn/widget/background.dart';
import 'package:messenger_flutter/views/SignUp/signup_screen.dart';
import 'package:messenger_flutter/views/home.dart';

class Body extends StatelessWidget
{
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  AuthService _authService = AuthService();

  /*const Body({
    Key key,
  }) : super(key: key);*/

  @override
  Widget build(BuildContext context)
  {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              controller: emailController,
              hintText: "Your Email",
              onChanged: (value)
              {

                print(value);
              },
            ),
            RoundedPasswordField(
              controller: passwordController,
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "LOGIN",
              press: ()
              {
                print('${emailController.text}');

                _authService.signInWithEmailAndPassword('${emailController.text}','${passwordController.text}');

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context)
                    {
                      return Home();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: ()
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context)
                    {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
