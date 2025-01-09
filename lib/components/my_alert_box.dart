import 'package:flutter/material.dart';

class MyAlertBox extends StatelessWidget {
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final String hintText;

  const MyAlertBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      content: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[600]),
        ),
      ),
      actions: [
        MaterialButton(
          onPressed: onSave,
          child: const Text(
            'Save',
            style: TextStyle(color: Colors.white),
          ),
        ),
        MaterialButton(
          onPressed: onCancel,
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
