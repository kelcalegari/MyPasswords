import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/editor.dart';
import 'Cadastro.dart';

const _rotuloCampoLogin = 'E-mail';
const _rotuloCampoSenha = 'Senha';

const _textoBotaoLogin = 'Login';

const String _rotuloCadastreSe = "Cadastre-se";

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  final TextEditingController _controladorCampoEmail = TextEditingController();
  final TextEditingController _controladorCampoSenha = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              controlador: _controladorCampoEmail,
              rotulo: _rotuloCampoLogin,
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
            Row(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right:20.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () => _realizarCadastro(context),
                    child: const Text(_rotuloCadastreSe),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              child: Text(_textoBotaoLogin),
              onPressed: () => _realizaLogin(context),
            ),
          ],
        ),
      ),
    );
  }
}

void _realizarCadastro(BuildContext context) {
  Navigator.push(context,
  MaterialPageRoute(builder: (context)=>  Cadastro()));
}


void _realizaLogin(BuildContext context) {
  debugPrint("Clique");
}
