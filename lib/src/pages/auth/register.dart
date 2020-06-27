import 'package:brasil_fields/brasil_fields.dart';
import 'package:covid19/src/pages/auth/register_input.dart';
import 'package:covid19/src/services/auth.dart';
import 'package:covid19/src/widgets/backgroud.dart';
import 'package:covid19/src/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  String name = '';
  String cpf = '';
  String phone = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      body: Background(
        widget: ListView(
          padding: const EdgeInsets.only(top: 80),
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 200),
                  Text(
                    "Registro",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 20),
                  RegisterInput(
                    text: 'Digíte seu nome',
                    validator: (val) => val.isEmpty ? 'Por favor, digíte seu nome' : null,
                    onChange: (val) {
                      setState(() => name = val);
                    }
                  ),
                  SizedBox(height: 20.0),
                  RegisterInput(
                      text: 'Digíte seu cpf',
                      keyboardType: TextInputType.number,
                      inputFormatter: [
                        WhitelistingTextInputFormatter.digitsOnly,
                        CpfInputFormatter()
                      ],
                      validator: (val) => val.isEmpty ? 'Por favor, digíte seu cpf' : null,
                      onChange: (val) {
                        setState(() => cpf = val);
                      }
                  ),
                  SizedBox(height: 20.0),
                  RegisterInput(
                      text: 'Selecione sua Cidade',
                      keyboardType: TextInputType.number,
                      inputFormatter: [
                        WhitelistingTextInputFormatter.digitsOnly,
                        TelefoneInputFormatter()
                      ],
                      validator: (val) => val.isEmpty ? 'Por favor, digíte seu telefone' : null,
                      onChange: (val) {
                        setState(() => phone = val);
                      }
                  ),
                  SizedBox(height: 20.0),
                  RegisterInput(
                      text: 'Digíte seu e-mail',
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) => val.isEmpty ? 'Por favor, digíte seu e-mail' : null,
                      onChange: (val) {
                        setState(() => email = val);
                      }
                  ),
                  SizedBox(height: 20.0),
                  RegisterInput(
                      text: 'Digíte sua senha',
                      obscureText: true,
                      validator: (val) => val.length < 6 ? 'Por favor, digíte uma senha com 6+ caracteres' : null,
                      onChange: (val) {
                        setState(() => password = val);
                      }
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    width: 320,
                    height: 47,
                    child: RaisedButton(
                        color: Colors.blue,
                        child: Text(
                          'Concluir o cadastro',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if(_formKey.currentState.validate()){
                            setState(() => loading = true);
                            dynamic result = await _auth.registerWithEmailAndPassword(email, password, name, cpf, phone);
                            if(result == null) {
                              setState(() {
                                loading = false;
                                error = 'Por favor, digíte um e-mail válido';
                              });
                            }
                          }
                        }
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                  SizedBox(height: 30),
                  RaisedButton(
                    elevation: 0,
                      color: Colors.transparent,
                      child: Text(
                        '< voltar para tela de login',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      onPressed: () => widget.toggleView(),
                  ),
                ],
              )
            ),
          ],
        )
      ),
    );
  }
}
