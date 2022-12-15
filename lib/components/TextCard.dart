// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextCard extends StatefulWidget {
  final String text, label;

  const TextCard(this.label, this.text, {super.key});

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return TextCardState(label, text);
  }
}

class TextCardState extends State<TextCard> {
  String text, label;

  TextCardState(this.label, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onLongPress: () {
          Clipboard.setData(ClipboardData(text: text));
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$text Copiado!!')));
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 10),
          child: Text(
            "$label: $text",
            textAlign: TextAlign.right,
            textScaleFactor: 1.5,
          ),
        ),
      ),
    );
  }
}
