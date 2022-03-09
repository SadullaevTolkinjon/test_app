import 'package:flutter/material.dart';
import 'package:test_zadaniya/constant/constant.dart';
import 'package:test_zadaniya/core/size_config/size_config.dart';

class TextFieldMy extends StatelessWidget {
  var controller;
  var hint;
  TextFieldMy({
    Key? key,
    this.controller,
    this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: ConstantsMy.padding,
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue),
            borderRadius:
                BorderRadius.circular(getProportionScreenHeight(100))),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            getProportionScreenHeight(100),
          ),
        ),
      ),
      validator: (val) {
        if (val!.isEmpty) {
          return "Shouldn't be empty";
        }
      },
    );
  }
}
