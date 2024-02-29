import 'package:flutter/material.dart';

class TextLabel extends StatelessWidget {
  final String texto;
  const TextLabel({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18, right: 18, left: 18 ),
      child: Text(texto,
          style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w700)),
    );
  }
}