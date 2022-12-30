import 'package:flutter/material.dart';
import 'package:ruiajournal/authentication/auth_service.dart';
// import 'package:provider/provider.dart';

class Provider extends InheritedWidget {
  final AuthService auth;

  Provider({Key key, Widget child, this.auth}) : super(key: key, child: child);

  //Workaround Without logging in
  // Provider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Provider of(BuildContext context) =>
      // (context.getElementForInheritedWidgetOfExactType() as Provider);
      (context.dependOnInheritedWidgetOfExactType<Provider>());
}
