import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/editor.dart';

const _rotuloCampoLogin = 'E-mail';
const _rotuloCampoSenha = 'Senha';

const _textoBotaoLogin = 'Login';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginScreen> {
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
              ocultar: true,
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

void _realizaLogin(BuildContext context) {
  debugPrint("Clique");
}
