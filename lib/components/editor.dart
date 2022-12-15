import 'package:flutter/material.dart';

class Editor extends StatefulWidget {
  final TextEditingController controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;
  final TextInputType textInputType;
  final bool senha;

  Editor({
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
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo != null ? rotulo : null,
          hintText: dica != null ? dica : null,
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
