import 'package:flutter/material.dart';
import 'package:messenger_flutter/components/text_field_container.dart';
import 'package:messenger_flutter/data/constants.dart';

class RoundedPasswordField extends StatelessWidget
{
  final ValueChanged<String> onChanged;
  final TextEditingController controller;

  const RoundedPasswordField(
  {
    Key key,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        obscureText: true,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}