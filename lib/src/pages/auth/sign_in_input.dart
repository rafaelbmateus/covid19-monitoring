import 'package:flutter/material.dart';

class SigInInput extends StatelessWidget {

  SigInInput({
    this.text,
    this.validator,
    this.onChange,
    this.obscureText=false
  });

  final String text;
  final bool obscureText;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 320,
        child: TextFormField(
          obscureText: obscureText,
          decoration: InputDecoration(
              fillColor: Colors.transparent,
              hintText: text,
              hintStyle: TextStyle(
                color: Colors.white,
              ),
              enabledBorder: new UnderlineInputBorder(
                  borderSide: new BorderSide(
                      color: Colors.white
                  )
              ),
              focusedBorder: new UnderlineInputBorder(
                  borderSide: new BorderSide(
                      color: Colors.white
                  )
              ),
              errorBorder: new UnderlineInputBorder(
                borderSide: new BorderSide(
                color: Colors.blue
                )
              )
          ),
          validator: validator,
          onChanged: onChange,
        )
    );
  }
}
