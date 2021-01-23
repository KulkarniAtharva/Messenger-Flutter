import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger_flutter/models/user_is_model.dart';

class AuthService
{
  FirebaseAuth auth = FirebaseAuth.instance;

  User1 _userFromFirebaseUser(User user)
  {
    return user != null ? User1(uid: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async
  {
    try
    {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: "atharvakulkarni2204@gmail.com", password: "123456");
      User user = userCredential.user;
      return _userFromFirebaseUser(user);
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