import 'package:covid19/src/pages/auth/sign_in_input.dart';
import 'package:covid19/src/services/auth.dart';
import 'package:covid19/src/widgets/backgroud.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        widget: ListView(
          padding: const EdgeInsets.only(top: 80),
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 200),
                    Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 20),
                    SigInInput(
                      text: 'Digíte seu e-mail',
                      validator: (val) => val.isEmpty ? 'Digíte seu e-mail' : null,
                      onChange: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20),
                    SigInInput(
                      text: 'Digíte sua senha',
                      obscureText: true,
                      validator: (val) => val.length < 6 ? 'Digíte uma senha com 6+ caracteres' : null,
                      onChange: (val) {
                        setState(() => password = val);
                      }
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: 320,
                      height: 47,
                      child: RaisedButton(
                          color: Colors.blue,
                          child: Text(
                            'Entrar',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if(_formKey.currentState.validate()){
                              setState(() => true);
                              dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                              if(result == null) {
                                setState(() {
                                  error = 'Ops, seu usuário ou senha estão incorreto';
                                });
                              }
                            }
                          }
                      ),
                    ),
                    SizedBox(height: 60),
                    Container(
                      width: 320,
                      height: 47,
                      child: SignInButton(
                        Buttons.Google,
                        text: "Entrar com o Google",
                        onPressed: () async {
                          setState(() => true);
                          bool res = await AuthService().signInWithGoogle();
                          if (!res) {
                            setState(() {
                              error = 'Ops, algo deu errado com o login da Google';
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 40),
                    RaisedButton(
                      elevation: 0,
                      color: Colors.transparent,
                      child: Text(
                        'Registre-se agora!',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900
                        ),
                      ),
                      onPressed: () => widget.toggleView(),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      )
    );
  }
}
