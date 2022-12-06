import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String? dica;
  final IconData? icone;
  final TextInputType textInputType;
  final bool ocultar;


  Editor({
    required this.controlador,
    required this.rotulo,
    this.dica,
    required this.textInputType,
    this.icone,
    this.ocultar = false,

  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica != null ? dica : null,
        ),
        keyboardType: textInputType,
        obscureText: ocultar,
      ),
    );
  }
}
