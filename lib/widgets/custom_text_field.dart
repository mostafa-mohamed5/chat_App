import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomFormTextField extends StatelessWidget {
   CustomFormTextField({
    super.key,
    this.hintText,
    this.onChanged,
    this.isEmail =false,
    this.isPassword = false
});

String? hintText;
Function (String)? onChanged;

 bool isEmail;

 bool isPassword;
  @override
  Widget build(BuildContext context) {
    return    TextFormField(
      obscureText: isPassword,
      validator: (data) {
        if(data!.isEmpty)
        {
          return 'field is requierd';
        }
        if (isEmail)
        {
          final emailRegExp = RegExp(r'^[\w\-\.]+@([\w-]+\.)+[\w-]{2,4}$');

          if (!emailRegExp.hasMatch(data)){
            return 'invalid email format';
          }
        }
        return null;
      },
      onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white
          ),
          enabledBorder:const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white
            )
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white
            )
          )
        ),
       );
  }
}