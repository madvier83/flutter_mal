import 'package:flutter/material.dart';

class Small extends StatelessWidget {
  final String text;
  const Small(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white38),
      overflow: TextOverflow.clip,
    );
  }
}
