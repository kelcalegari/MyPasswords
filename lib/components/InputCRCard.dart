// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'Editor.dart';

class InputCRCard extends StatelessWidget {
   final TextEditingController primeiroController, segundoController;

  const InputCRCard(this.primeiroController, this.segundoController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Editor(
            controlador: primeiroController,
            textInputType: TextInputType.visiblePassword,
          ),
        ),
        Expanded(
          child: Editor(
            controlador: segundoController,
            textInputType: TextInputType.visiblePassword,
          ),
        ),
      ],
    );
  }
}
