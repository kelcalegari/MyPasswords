import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/editor.dart';


const _rotuloCampoEmail = 'E-mail';
const _rotuloCampoSenha = 'Senha';
const _rotuloCampoRepetirSenha = 'Repita Senha';
const _textoBotaoSalvar = 'Salvar';

class Cadastro extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CadastroState();
  }

}

class CadastroState extends State<Cadastro>{
  final TextEditingController _controladorCampoEmail = TextEditingController();
  final TextEditingController _controladorCampoSenha = TextEditingController();
  final TextEditingController _controladorRepetirCampoSenha = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              controlador: _controladorCampoEmail,
              rotulo: _rotuloCampoEmail,
              icone: Icons.account_circle_outlined,
              textInputType: TextInputType.emailAddress,
            ),
            Editor(
              controlador: _controladorCampoSenha,
              rotulo: _rotuloCampoSenha,
              icone: Icons.lock,
              textInputType: TextInputType.visiblePassword,
              senha: true,
            ),
            Editor(
              controlador: _controladorRepetirCampoSenha,
              rotulo: _rotuloCampoRepetirSenha,
              icone: Icons.lock,
              textInputType: TextInputType.visiblePassword,
              senha: true,
            ),

            ElevatedButton(
              child: Text(_textoBotaoSalvar),
              onPressed: () => _realizaCadastro(context),
            ),
          ],
        ),
      ),
    );
  }
}

void _realizaCadastro (BuildContext context){
}