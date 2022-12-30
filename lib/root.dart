// import 'package:flutter/material.dart';
// import 'package:ruiajournal/home_student.dart';
// import 'package:ruiajournal/startup/login.dart';

// enum AuthStatus {
//   notLoggedIn,
//   loggedIn,
// }
// import 'package:flutter/material.dart';

// class Root extends StatefulWidget {
//   @override
//   _RootState createState() => _RootState();
// }

// class _RootState extends State<Root> {
//   AuthStatus _authStatus = AuthStatus.notLoggedIn;

//   @override
//   void didChangeDependencies() async {
//     // TODO: didChangeDependencies
//     super.didChangeDependencies();

//     //get the state, check current user, set authStatus
//     CurrentUser _currentUser = Provider.of(context, listen: false);
//     String _returnString = await _currentUser.onStartUp();
//     if (_returnString == "success") {
//       setState(() {
//         _authStatus = AuthStatus.loggedIn;
//       });
//     }
//   }

//   Widget build(BuildContext context) {
//     Widget retVal;

//     switch (_authStatus) {
//       case AuthStatus.notLoggedIn:
//         retVal = Login(authFormType: AuthFormType.login);
//         break;
//       case AuthStatus.loggedIn:
//         retVal = Home();
//         break;
//       default:
//     }
//     return retVal;
//   }
// }
