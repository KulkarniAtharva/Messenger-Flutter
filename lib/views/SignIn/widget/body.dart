import 'package:edge_alert/edge_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:messenger_flutter/components/already_have_an_account_acheck.dart';
import 'package:messenger_flutter/components/rounded_button.dart';
import 'package:messenger_flutter/components/rounded_input_field.dart';
import 'package:messenger_flutter/components/rounded_password_field.dart';
import 'package:messenger_flutter/data/constants.dart';
import 'package:messenger_flutter/services/auth.dart';
import 'package:messenger_flutter/views/SignIn/widget/background.dart';
import 'package:messenger_flutter/views/SignUp/signup_screen.dart';
import 'package:messenger_flutter/views/home.dart';

class Body extends StatelessWidget
{
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  String error = '';
  String email;
  String password;
  final auth = FirebaseAuth.instance;

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
              press: () async
              {
                print('${emailController.text}');

                email = emailController.text;
                password = passwordController.text;

               /* if(password != null && email != null)
                {
                 /* setState(()
                  {
                    loggingin = true;
                  });*/
                  try
                  {
                    //final loggedUser = await auth.signInWithEmailAndPassword(email: 'a@gmail.com', password: '111111');
                    FirebaseUser user = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(email: 'a@gmail.com', password: '111111');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Home()));

                    //if(loggedUser != null)
                    {
                      /*setState(()
                      {
                        loggingin = false;
                      });*/
                    /*  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home()));*/
                    }
                  }
                  catch (e)
                  {
                   /* setState(()
                    {
                      loggingin = false;
                    });*/
                    EdgeAlert.show(context,
                        title: 'Login Failed',
                        description: e.toString(),
                        gravity: EdgeAlert.BOTTOM,
                        icon: Icons.error,
                        backgroundColor: Colors.deepPurple[900]);
                  }
                }
                else
                {
                  EdgeAlert.show(context,
                      title: 'Uh oh!',
                      description:
                      'Please enter the email and password.',
                      gravity: EdgeAlert.BOTTOM,
                      icon: Icons.error,
                      backgroundColor: Colors.deepPurple[900]);
                }*/

               await _authService.signInWithEmailAndPassword('${emailController.text}','${passwordController.text}', context).then((result)
               {
                  if (result == null)
                  {
                    /* setState(()
                   {
                     error = "please supply a valid email";
                    // _loading = false;
                   });*/
                  }
                  else
                  {
                    print('signIn succeeded: $result');

                    // Constants.saveUserLoggedInSharedPreference(true);
                    // Constants.saveUserNameSharedPreference(userInfoSnapshot.docs[0].data()["userName"]);
                    //Constants.saveUserAvatarSharedPreference(userInfoSnapshot.docs[0].data()["avatarUrl"]);
                    //  Constants.saveUserEmailSharedPreference(emailController.text);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Home()));
                  }
                });
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
