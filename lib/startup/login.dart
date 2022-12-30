import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ruiajournal/authentication/provider_widget.dart';
import 'package:ruiajournal/authentication/auth_service.dart';
import 'package:ruiajournal/startup/background.dart';

final primaryColor = const Color(0xFF75A2Ef2);
enum AuthFormType { login, reset }

class Login extends StatefulWidget {
  final AuthFormType authFormType;
  Login({Key key, @required this.authFormType}) : super(key: key);

  @override
  _LoginState createState() => _LoginState(authFormType: this.authFormType);
}

class _LoginState extends State<Login> {
  AuthFormType authFormType;
  _LoginState({this.authFormType});

  final formKey = GlobalKey<FormState>();
  String _email, _password, _warning;

  // SWITCH BETWEEN LOGIN AND RESET
  void switchFormState(String state) {
    formKey.currentState.reset();
    if (state == "login") {
      setState(() {
        authFormType = AuthFormType.login;
      });
    } else if (state == "reset") {
      setState(() {
        authFormType = AuthFormType.reset;
      });
    }
  }

  // VALIDATION CHECK
  bool validate() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  // LOGIN BUTTON ON PRESSED
  void submit() async {
    if (validate()) {
      try {
        //CALLING auth FROM PROVIDER FROM main.dart
        final auth = Provider.of(context).auth;

        bool isLoading;
        if (authFormType == AuthFormType.login) {
          String uid = await auth.signInWithEmailAndPassword(_email, _password);
          print("Signed in with ID $uid");

          Navigator.of(context).pushNamedAndRemoveUntil(
              "/home", (Route<dynamic> route) => false);

          DocumentReference documentReference =
              FirebaseFirestore.instance.collection("Students").doc(uid);
          documentReference.get().then((datasnapshot) {
            print(datasnapshot.data());

            return isLoading = true;
          });
          print("Read data successfully");
        }

        // PASSWORD RESET PAGE
        else if (authFormType == AuthFormType.reset) {
          await auth.sendPasswordResetEmail(_email);
          print("Password reset email sent");
          _warning = "A password reset link has been sent to $_email";
          setState(() {
            authFormType = AuthFormType.login;
          });
        }
      } catch (e) {
        setState(() {
          _warning = e.message;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Background(
          child: Column(
            children: [
              SizedBox(height: _height * 0.15),
              Container(
                  padding: EdgeInsets.only(left: 20),
                  alignment: Alignment.topLeft,
                  
                  width: _width,
                  height: 110,
                  child: Image.asset(
                    "assets/ruiavector.png",
                    colorBlendMode: BlendMode.color,
                    alignment: Alignment.center,
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: _height * 0.10),

                  // CALLING HEADER TEXT BUILDER
                  Container(
                    padding: EdgeInsets.only(left: 25),
                    alignment: Alignment.centerLeft,
                    child: buildHeaderText(),
                  ),
                  
                  // CALLING FIREBASE ERRORS ALERT
                  SizedBox(height: 10),
                  showAlert(),
                  
                  // TEXTFIELDS + LOGIN
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                          key: formKey,
                          child: Column(
                            children:
                                buildInputs() + sizedBox() + buildButtons(),
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> sizedBox() {
    List<Widget> sizedBox = [];
    sizedBox.add(SizedBox(height: MediaQuery.of(context).size.height * 0.035));
    return sizedBox;
  }

  // DISPLAY FIREBASE ERRORS
  Widget showAlert() {
    if (_warning != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.only(left: 8),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(child: AutoSizeText(_warning, maxLines: 3)),

            // CLOSE ERROR ON SCREEN
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _warning = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(height: 0);
  }

  // HEADER TEXT
  AutoSizeText buildHeaderText() {
    String _headerText;
    if (authFormType == AuthFormType.login) {
      _headerText = "LOGIN";
    } else if (authFormType == AuthFormType.reset) {
      _headerText = "RESET";
    }
    return AutoSizeText(
      _headerText,
      maxLines: 1,
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 40, color: Color(0xFF2661FA)),
    );
  }

  // TEXT FIELDS
  List<Widget> buildInputs() {
    List<Widget> textFields = [];

    // EMAIL FIELD FOR FORGOT PASSWORD
    if (authFormType == AuthFormType.reset) {
      textFields.add(TextFormField(
        textInputAction: TextInputAction.send,
        validator: EmailValidator.validate,
        style: TextStyle(fontSize: 17),
        decoration: buildLoginInputDecoration("Email"),
        onSaved: (value) => _email = value,
        inputFormatters: [
          FilteringTextInputFormatter(new RegExp(r"\s\b|\b\s"), allow: false)
        ],
      ));
      textFields.add(SizedBox(height: 20));
      return textFields;
    }

    // EMAIL FIELD
    textFields.add(TextFormField(
      textInputAction: TextInputAction.next,
      validator: EmailValidator.validate,
      style: TextStyle(fontSize: 17),
      decoration: buildLoginInputDecoration("Email"),
      onSaved: (value) => _email = value,
    ));

    textFields.add(SizedBox(height: 20));

    // PASSWORD FIELD
    textFields.add(TextFormField(
      textInputAction: TextInputAction.send,
      validator: PasswordVaildator.validate,
      style: TextStyle(fontSize: 17),
      decoration: buildLoginInputDecoration("Password"),
      obscureText: true,
      onSaved: (value) => _password = value,
      // onFieldSubmitted: ,
    ));
    // }
    textFields.add(SizedBox(height: 20));
    return textFields;
  }

  // TEXTBOX STYLING
  InputDecoration buildLoginInputDecoration(String hint) {
    return InputDecoration(
      labelText: hint,
      // hintText: hint,
      filled: true,
      fillColor: Color(0xFFFFFFFF),
      focusColor: Colors.black,
      disabledBorder: InputBorder.none,

      // enabledBorder: OutlineInputBorder(
      //     borderSide: BorderSide(color: Color(0xFF2661FA), width: 3)),
      contentPadding: const EdgeInsets.only(left: 14, bottom: 10, top: 10),
    );
  }

  // BUTTONS
  List<Widget> buildButtons() {
    String _switchButtonText, _newFormState, _submitButtonText;
    bool isLoading = false;

    if (authFormType == AuthFormType.login) {
      _switchButtonText = "Forgot Password?";
      _newFormState = "reset";
      _submitButtonText = "Login";
    } else if (authFormType == AuthFormType.reset) {
      _switchButtonText = "Back to login";
      _newFormState = "login";
      _submitButtonText = "Submit";
    }

    return [
      Container(
        width: MediaQuery.of(context).size.width * 0.5,
        child: RaisedButton(
            onPressed: () {
              isLoading = true;
              submit();
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            color: Color(0xFF2661FA),
            textColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Text(
                      _submitButtonText,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
            )
            ),
      ),
      FlatButton(
        child: Text(_switchButtonText,
            style: TextStyle(
                color: Color(0xFF2661FA),
                fontStyle: FontStyle.italic,
                fontSize: 17)),
        onPressed: () {
          switchFormState(_newFormState);
        },
      )
    ];
  }
}
