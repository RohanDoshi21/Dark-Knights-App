import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darkknightspict/Admin/admin_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SignIn {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInWithGoogle() async {
    late final bool isNewUser;
    try {
      UserCredential userCredential;
      if (kIsWeb) {
        var googleProvider = GoogleAuthProvider();
        userCredential = await _auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication googleAuth =
            await googleUser!.authentication;
        final googleAuthCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        userCredential = await _auth.signInWithCredential(googleAuthCredential);
        isNewUser = userCredential.additionalUserInfo!.isNewUser;
      }
      if (isNewUser) {
        storeUserDetails();
      }
      return;
    } catch (e) {
      return e;
    }
  }

  Future<void> storeUserDetails() async {
    final CollectionReference usercollection =
        FirebaseFirestore.instance.collection('Users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    String email = auth.currentUser!.email.toString();
    User? user = auth.currentUser;

    usercollection.doc(uid).set({
      "displayName": user!.displayName,
      "phoneNumber": user.phoneNumber,
      "email": email,
      "photoURL": user.photoURL,
      "uid": user.uid,
      "lastMessageTime": Timestamp.now(),
      "isAdmin": false,
    }, SetOptions(merge: true));

    final CollectionReference chatCollection = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Chats');
    chatCollection.add(
      {
        "displayName": AdminInfo.displayName,
        "phoneNumber": AdminInfo.phoneNumber,
        "email": AdminInfo.email,
        "photoURL": AdminInfo.photoURL,
        "uid": AdminInfo.uid,
        "createdAt": Timestamp.now(),
        "Message":
            "Hi there I am your CA, Welcome to this app! Feel free to ask any doubts here!",
      },
    );
    return;
  }
}
