import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:messenger_flutter/data/constants.dart';
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


  Future<User> signInWithGoogle(BuildContext context) async
  {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = new GoogleSignIn();

    final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);

    UserCredential result = await _firebaseAuth.signInWithCredential(credential);
    User userDetails = result.user;

    if (result == null)
    {
    }
    else
    {
      Constants.saveUserLoggedInSharedPreference(true);
      Constants.saveUserNameSharedPreference(userDetails.email.replaceAll("@gmail.com", "").toLowerCase());
      Constants.saveUserAvatarSharedPreference(userDetails.photoURL);
      Constants.saveUserEmailSharedPreference(userDetails.email);
      Navigator.push(context, MaterialPageRoute(builder: (context) => WebHome()));
    }

    return userDetails;
  }

  // sign up with email and password
  Future signUpWithEmailAndPassword(String email, String password) async
  {
    try
    {
      UserCredential result = await auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch (e)
    {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async
  {
    try
    {
      return await auth.signOut();
    }
    catch (e)
    {
      print(e.toString());
      return null;
    }
  }

  Future resetPass(String email) async
  {
    try
    {
      return await auth.sendPasswordResetEmail(email: email);
    }
    catch (e)
    {
      print(e.toString());
      return null;
    }
  }
}