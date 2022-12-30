// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:ruiajournal/auth_service.dart';
// import 'package:provider/provider.dart';
// import 'package:ruiajournal/homeold.dart';

// class Login extends StatefulWidget {
//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   final TextEditingController emailController = TextEditingController();

//   final TextEditingController passwordController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();
//   String _email, _password, error;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
//         child: Form(
//             key: _formKey,
//             child: Column(children: [
//               SizedBox(height: 50),
//               TextFormField(
//                 validator: (val) => val.isEmpty ? "Enter an email" : null,
//                 controller: emailController,
//                 decoration: InputDecoration(labelText: "Email"),
//                 onSaved: (val) => _email = val,
//               ),
//               TextFormField(
//                 validator: (val) {
//                   if (val.isEmpty) {
//                     return "Enter your password";
//                   }
//                   if (val.length < 6) {
//                     return "Password should be greater than 6 characters";
//                   }
//                   return null;
//                 },
//                 controller: passwordController,
//                 obscureText: true,
//                 decoration: InputDecoration(labelText: "Password"),
//                 onSaved: (val) => _password = val,
//               ),
//               RaisedButton(
//                 onPressed: signIn,
//                 // onPressed: () {
//                 // if (_formKey.currentState.validate()) {
//                 //   context.read<AuthenticationService>().signIn(
//                 //         email: emailController.text.trim(),
//                 //         password: passwordController.text.trim(),
//                 //       );
//                 // }
//                 // },
//                 child: Text("Login"),
//               ),
//               SizedBox(height: 20),
//               // Text(error, style: TextStyle(color: Colors.red, fontSize: 15)),
//             ])),
//       ),
//     );
//   }

//   // OLD METHOD
//   Future<void> signIn() async {
//     final formState = _formKey.currentState;
//     if (formState.validate()) {
//       formState.save();
//       try {
//         UserCredential userCredential = (await FirebaseAuth.instance
//             .signInWithEmailAndPassword(email: _email, password: _password));
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (context) => Home()));
//       } catch (e) {
//         print(e.message);
//       }
//     }
//   }
// }
