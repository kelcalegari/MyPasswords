import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/editor.dart';
import '../ListLogins/ListLogins.dart';

const _rotuloCampoEmail = 'E-mail';
const _rotuloCampoSenha = 'Senha';
const _rotuloCampoRepetirSenha = 'Repita Senha';
const _textoBotaoSalvar = 'Salvar';

class Cadastro extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CadastroState();
  }
}

class CadastroState extends State<Cadastro> {
  final TextEditingController _controladorCampoEmail = TextEditingController();
  final TextEditingController _controladorCampoSenha = TextEditingController();
  final TextEditingController _controladorRepetirCampoSenha =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
              onPressed: () => _realizaCadastro(
                  context,
                  _controladorCampoEmail.text,
                  _controladorCampoSenha.text,
                  _controladorRepetirCampoSenha.text),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _realizaCadastro(BuildContext context, String eMail, String senha,
    String repitirSenha) async {
  if (senha == repitirSenha) {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        password: senha,
        email: eMail,
      );

      Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context)=>  ListLogins()),
            (Route<dynamic> route) => false,);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        alerta(context, "Senha Fraca!!!");
      } else if (e.code == 'email-already-in-use') {
        alerta(context, "Email já existente!!!");
      }
    } catch (e) {
      print(e);
    }
  } else {
    debugPrint("Senhas não confere");
    alerta(context, "Senhas não confere!!!");
  }
}

void alerta(BuildContext context, String mensagem) {
  debugPrint("Alerta " + mensagem);
  AlertDialog alerta = AlertDialog(
    title: Text("Alerta"),
    content: Text(mensagem),
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}
