import 'package:flutter/material.dart';

const robotoMedium = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: Colors.black);

// ignore: must_be_immutable
class CustomInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool disabled;

  String? Function(String? value)? valdate;
  final EdgeInsetsGeometry margin;
  final bool obsecureText;
  final Widget? suffixIcon;
  TextInputType? keyboardType;
  CustomInput(
      {super.key,
      this.valdate,
      required this.controller,
      required this.label,
      required this.hint,
      this.disabled = false,
      this.margin = const EdgeInsets.only(bottom: 16),
      this.obsecureText = false,
      this.suffixIcon,
      this.keyboardType});

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 55,
        child: TextFormField(
            validator: widget.valdate,
            keyboardType: widget.keyboardType,
            readOnly: widget.disabled,
            obscureText: widget.obsecureText,
            style: robotoMedium,
            maxLines: 1,
            controller: widget.controller,
            decoration: InputDecoration(
              suffixIcon: widget.suffixIcon,
              label: Text(widget.label,
                  style: robotoMedium.copyWith(color: Colors.black)),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              hintText: widget.hint,
              hintStyle: robotoMedium.copyWith(color: Colors.black),
            )),
      ),
    );
  }
}
