import 'package:covid19/src/model/user.dart';
import 'package:covid19/src/pages/auth/auth.dart';
import 'package:covid19/src/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null){
      return Authenticate();
    } else {
      return HomePage();
    }
  }
}
