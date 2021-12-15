import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:note_app/pages/homepage.dart';

GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference users = FirebaseFirestore.instance.collection('users');

Future signInWithGoogle(BuildContext context) async {
  try{
    //for sign google sign in prompt and selecting one google account
    final GoogleSignInAccount?  googleSignInAccount= await googleSignIn.signIn();

    if(googleSignInAccount!=null)
      {// we are taking access token of choosen google account to create firebase user.
        GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount.authentication;

        //taking id token and accesstoken to create firebase user.
        final AuthCredential credential  = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        //sign in with firebase
        final UserCredential authResult = await auth.signInWithCredential(credential);
        final User? user = authResult.user; //creating user in authentication panel of firebase

        var userData = {
          'name' : googleSignInAccount.displayName,
          'provider' : 'google',
          'photoUrl': googleSignInAccount.photoUrl,
          'email' : googleSignInAccount.email,
        };

        //users is firestore collection
        //users.doc(user?.uid) , it match with user uid in authentication panel and in firestore's collection's document id
        //get() use to read the matched doc reference
        // .then((doc) => , doc have snapshot of matched doc refernce
        users.doc(user?.uid).get().then((doc){
          if(doc.exists){
            //old user
            doc.reference.update(userData);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage(),)
            );
          }
          else{
            //new user
            users.doc(user?.uid).set(userData);
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage(),)
            );
          }
        });
      }
  }
  catch(PlatformException)
  {
    print(PlatformException);
    print("Sign in not succeful!");
  }
}