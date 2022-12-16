// ignore_for_file: file_names, no_logic_in_create_state

import 'package:flutter/material.dart';

class Editor extends StatefulWidget {
  final TextEditingController controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;
  final TextInputType textInputType;
  final bool senha;

  const Editor({super.key,
    required this.controlador,
    this.rotulo,
    this.dica,
    required this.textInputType,
    this.icone,
    this.senha = false,
  });
  @override
  State<StatefulWidget> createState() {
    return EditorState(
      controlador: controlador,
      rotulo: rotulo,
      dica: dica,
      icone: icone,
      textInputType: textInputType,
      senha: senha,
    );
  }
}

class EditorState extends State<Editor> {
  final TextEditingController controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;
  final TextInputType textInputType;
  final bool senha;
  bool _passwordVisible = false;

  EditorState({
    required this.controlador,
    this.rotulo,
    this.dica,
    required this.textInputType,
    this.icone,
    this.senha = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16,right: 16),
      child: TextField(
        controller: controlador,
        style: const TextStyle(fontSize: 24.0),

        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
          suffixIcon: senha != false ? IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              _passwordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ): null,
        ),
        keyboardType: textInputType,
        obscureText: !_passwordVisible && senha,

      ),
    );
  }

}
