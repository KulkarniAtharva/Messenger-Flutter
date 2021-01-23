import 'package:firebase_auth/firebase_auth.dart';

class AuthService
{
  FirebaseAuth auth = FirebaseAuth.instance;

  signInWithEmailAndPassword(String email, String password) async
  {
    try
    {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: "atharvakulkarni2204@gmail.com",
          password: "123456"
      );
    }
    on FirebaseAuthException catch (e)
    {
      if (e.code == 'user-not-found')
      {
        print('No user found for that email.');
      }
      else if (e.code == 'wrong-password')
      {
        print('Wrong password provided for that user.');
      }
    }
  }
}