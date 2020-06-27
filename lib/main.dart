import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:covid19/src/config/route.dart';
import 'package:covid19/src/theme/theme.dart';
import 'package:covid19/src/services/auth.dart';
import 'package:covid19/src/model/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Covid-19 Monitoring',
        theme: AppTheme.lightTheme,
        routes: Routes.getRoute(),
        onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
        debugShowCheckedModeBanner: false,
        initialRoute: "SplashPage",
      ),
    );
  }
}

