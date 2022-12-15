
// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/Editor.dart';
import '../ListLogins/ListLogins.dart';

const _rotuloCampoEmail = 'E-mail';
const _rotuloCampoSenha = 'Senha';
const _rotuloCampoRepetirSenha = 'Repita Senha';
const _textoBotaoSalvar = 'Salvar';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(title: const Text("Login")),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: Editor(
                controlador: _controladorCampoEmail,
                rotulo: _rotuloCampoEmail,
                icone: Icons.account_circle_outlined,
                textInputType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Editor(
                controlador: _controladorCampoSenha,
                rotulo: _rotuloCampoSenha,
                icone: Icons.lock,
                textInputType: TextInputType.visiblePassword,
                senha: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Editor(
                controlador: _controladorRepetirCampoSenha,
                rotulo: _rotuloCampoRepetirSenha,
                icone: Icons.lock,
                textInputType: TextInputType.visiblePassword,
                senha: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                child: const SizedBox(
                  height: 40,
                  width: 150,
                  child: Center(
                    child: Text(_textoBotaoSalvar,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 25)),
                  ),
                ),
                onPressed: () => _realizaCadastro(
                    context,
                    _controladorCampoEmail.text,
                    _controladorCampoSenha.text,
                    _controladorRepetirCampoSenha.text),
              ),
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
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        password: senha,
        email: eMail,
      );

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => ListLogins()),
        (Route<dynamic> route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        alerta(context, "Senha Fraca!!!");
      } else if (e.code == 'email-already-in-use') {
        alerta(context, "Email já existente!!!");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  } else {

    alerta(context, "Senhas não confere!!!");
  }
}

void alerta(BuildContext context, String mensagem) {

  AlertDialog alerta = AlertDialog(
    title: const Text("Alerta"),
    content: Text(mensagem),
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}
