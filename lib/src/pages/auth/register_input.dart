import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterInput extends StatelessWidget {

  RegisterInput({
    this.text,
    this.validator,
    this.onChange,
    this.obscureText=false,
    this.inputFormatter,
    this.keyboardType,
  });

  final String text;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onChange;
  final bool obscureText;
  final List<TextInputFormatter> inputFormatter;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      child: TextFormField(
        keyboardType: keyboardType,
        inputFormatters: inputFormatter,
        obscureText: obscureText,
        style: TextStyle(
            color: Colors.white
        ),
        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide:  new BorderSide(
                  color: Colors.white
              )
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: new BorderSide(
                  color: Colors.black
              )
          ),
        ),
        validator: validator,
        onChanged: onChange,
      ),
    );
  }
}
