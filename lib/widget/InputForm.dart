import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;

  const InputForm({
    required this.label,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 12),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          style: TextStyle(fontSize: 12),
          decoration: InputDecoration(
            fillColor: Color(0xffFFFFFF),
            filled: true,
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: const BorderSide(
                color: Color(0xffDEDEDF),
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xffEBEBEC),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
