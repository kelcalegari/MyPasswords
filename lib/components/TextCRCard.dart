// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextCRCard extends StatelessWidget {
 final String primeiroText, segundoText;

  const TextCRCard(this.primeiroText, this.segundoText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onLongPress: () {
          Clipboard.setData(ClipboardData(text: primeiroText + segundoText));
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$primeiroText$segundoText Copiado!!')));
        },
        child: Row(
          children: <Widget>[
            Expanded(
                child: Text(
              primeiroText,
              textAlign: TextAlign.center,
              textScaleFactor: 1.5,
            )),
            Expanded(
                child: Text(
              segundoText,
              textAlign: TextAlign.center,
              textScaleFactor: 1.5,
            )),
          ],
        ),
      ),
    );
  }
}
