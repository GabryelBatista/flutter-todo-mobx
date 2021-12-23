import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hint;
  final Widget? suffix;
  final IconData? preffix;
  final bool? enable;
  final bool? obscure;
  final TextEditingController? controller;
  final Function(String)? changed;

  const CustomTextField(
      {Key? key,
      required this.hint,
      required this.suffix,
      required this.preffix,
      this.changed = null,
      this.obscure = false,
      this.enable = true,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(7.5),
      child: TextFormField(
        enabled: enable,
        obscureText: obscure!,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade200,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(30)),
            prefixIcon: Padding(
              padding: const EdgeInsetsDirectional.only(start: 10),
              child: Icon(preffix),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsetsDirectional.only(end: 15),
              child: suffix,
            ),
            hintText: hint),
        onChanged: changed,
        controller: controller,
      ),
    );
  }
}
