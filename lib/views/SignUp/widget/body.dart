import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:messenger_flutter/components/already_have_an_account_acheck.dart';
import 'package:messenger_flutter/components/rounded_button.dart';
import 'package:messenger_flutter/components/rounded_input_field.dart';
import 'package:messenger_flutter/components/rounded_password_field.dart';
import 'package:messenger_flutter/services/auth.dart';
import 'package:messenger_flutter/views/SignIn/login_screen.dart';
import 'package:messenger_flutter/views/SignUp/widget/background.dart';
import 'package:messenger_flutter/views/SignUp/widget/or_divider.dart';
import 'package:messenger_flutter/views/SignUp/widget/social_icon.dart';
import 'package:messenger_flutter/views/home.dart';

class Body extends StatelessWidget
{
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  AuthService _authService = AuthService();

  String email;
  String password;

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
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              controller: emailController,
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              controller: passwordController,
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () async
              {
                email = emailController.text;
                password = passwordController.text;

                await _authService.signUpWithEmailAndPassword(email, password,context).then((value)
                {
                  if (value != null)
                  {
                    /// uploading user info to Firestore
                    Map<String, String> userInfo =
                    {
                      //"userName": name,
                      "email": email,
                      //"avatarUrl": selectedAvatarUrl,
                    };

                    /*DatabaseMethods()
                        .addData(userInfo)
                        .then((result) {});*/

                   /* Constants.saveUserLoggedInSharedPreference(true);
                    Constants.saveUserNameSharedPreference(name);
                    print("$name username saved");
                    Constants.saveUserAvatarSharedPreference(selectedAvatarUrl);
                    print("$selectedAvatarUrl user avatar saved");
                    Constants.saveUserEmailSharedPreference(email);
                    print("$email user email saved");*/

                   /* setState(()
                    {
                      _loading = false;
                    });*/

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Home()));
                  }
                  else
                  {
                    /*setState(()
                    {
                      _loading = false;
                      error = "please supply a valid/another email";
                    });*/
                  }
                });
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
