import 'package:flutter/material.dart';

class Customtext extends StatelessWidget {
  Customtext(
      {super.key,
      this.color,
      this.controller,
      required this.hintext,
      this.obscureText = false,
      this.icon,
      this.onchange,
      this.icon1,
      this.on,
      this.pass,
      this.keybo
      });
  Color? color;
  
  String hintext;
  TextEditingController? controller;
  bool? obscureText;
  String? pass;
  final IconData? icon;
  final IconData? icon1;
  final TextInputType? keybo;
  final Function()? on;
  final void Function(String)? onchange;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onChanged: onchange,
        controller: controller,
        keyboardType: keybo,
        obscureText: obscureText!,
        validator: (val) => val!.length < 6 ? 'password too short' : null,
        onSaved: (val) => pass = val!,
        decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: on,
              icon: Icon(
                icon1,
                color: color,
              ),
            ),
            prefixIcon: Icon(icon),
            hintText: hintext,
            hintStyle: const TextStyle(
              color: Colors.white,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  color: Colors.white,
                ))),
      ),
    );
  }
}
