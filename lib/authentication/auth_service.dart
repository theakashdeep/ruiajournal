import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:ruiajournal/admin/home_admin.dart';
import 'package:ruiajournal/home_student.dart';
// import 'package:ruiajournal/startup/welcome.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get authStateChanges => _firebaseAuth.authStateChanges().map(
        (User user) => user?.uid,
      );

  //dsd
  // Future<String> onStartUp() async {
  //   String retVal = "error";

  //   try {
  //     User _user = await _firebaseAuth.currentUser();
  //     _uid = _user.uid;
  //     _email = _user.email;
  //     retVal = "success";
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // LOGIN WITH Email and password
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user
        .uid;
  }

  // Get UID
  Future<String> getCurrentUID() async {
    return _firebaseAuth.currentUser.uid;
  }

  //GET Current User
  Future<String> getCurrentUser() async {
    return _firebaseAuth.currentUser.displayName;
  }

  // LOGOUT
  signOut() {
    return _firebaseAuth.signOut();
    // Navigator.pushReplacementNamed(context, "login");
  }

  // RESET PASSWORD
  Future sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}

// VALIDATIONS
class EmailValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Enter an email";
    }
    return null;
  }
}

class PasswordVaildator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Enter your password";
    }
    if (value.length < 6) {
      return "Your password should be atleast 6 characters";
    }
    return null;
  }
}

class NameValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Cannot be empty";
    }
    return null;
  }
}

// CHECK USER TYPE
authorizeAccess(BuildContext context) {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // currentUser.add(snapshot.data.uid);
  // final user = _auth.currentUser();
  FirebaseFirestore.instance
      .collection('/users')
      .where('uid', isEqualTo: _auth.currentUser.uid)
      .get()
      .then((value) {
    if (value.docs[0].exists) {
      if (value.docs[0].data()['Role'] == 'Admin') {
        return Home();
      } else {
        return AdminHome();
      }
    }
  });
}

// userManagement(BuildContext context) {
// // if (snapshot.hasData && snapshot.data != null) {
//   StreamBuilder(
//     stream: FirebaseFirestore.instance.collection("users").doc().snapshots(),
//     builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//       if (snapshot.hasData && snapshot.data != null) {
//         final user = snapshot.data.data();
//         if (user['Role'] == 'admin') {
//           // if () {
//           return AdminHome();
//         } else {
//           return Home();
//         }
//       }
//       return Welcome();
//     },
//   );
// }
// }

// GET UID
// Future<String> getCurrentUID() async {
// return (await _firebaseAuth.currentUser()).uid;
// final user = await _firebaseAuth.currentUser;
// return user;
// }

// getUID() {
//   FutureBuilder(
//     future: FirebaseAuth.instance.currentUser(),
//     builder: (context, AsyncSnapshot<User> snapshot) {
//       if (snapshot.hasData) {
//         return Text(snapshot.data.uid);
//       } else {
//         return CircularProgressIndicator();
//       }
//     },
//   );
// }

// REGISTER WITH Email and Password
// Future<String> createUserWithEmailAndPassword(
//     String email, String password, String name) async {
//   final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
//       email: email, password: password);

//OLD method - Update the username
// Future updateUserName(String name, User currentUser) async {
//   var userUpdateInfo = UserUpdateInfo();
//   userUpdateInfo.displayName = name;
//   await currentUser.updateProfile(userUpdateInfo);
//   await currentUser.reload();
//   // return currentUser.uid;
// }
