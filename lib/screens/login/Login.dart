// ignore: file_names
import 'package:codigo/screens/ListLogins/ListLogins.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/Editor.dart';
import 'Cadastro.dart';

const _rotuloCampoLogin = 'E-mail';
const _rotuloCampoSenha = 'Senha';

const _textoBotaoLogin = 'Login';

const _rotuloCadastreSe = "Cadastre-se";
const _rotuloEsqueceu = "Recuperar a senha";

class Login extends StatefulWidget {
  const Login({super.key});

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
    final email = FirebaseAuth.instance.currentUser?.email;
    if (email != null) {
      _controladorCampoEmail.text = email;
    }
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
                rotulo: _rotuloCampoLogin,
                icone: Icons.account_circle_outlined,
                textInputType: TextInputType.emailAddress,
              ),
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
                  padding: const EdgeInsets.only(right: 20.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () =>
                        _redefinirSenha(_controladorCampoEmail.text),
                    child: const Text(_rotuloEsqueceu),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ElevatedButton(
                          child: const SizedBox(
                            height: 40,
                            width: 160,
                            child: Center(
                              child: Text(_rotuloCadastreSe,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20)),
                            ),
                          ),
                          onPressed: () => _realizarCadastro(context),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ElevatedButton(
                          child: const SizedBox(
                            height: 40,
                            width: 160,
                            child: Center(
                              child: Text(_textoBotaoLogin,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20)),
                            ),
                          ),
                          onPressed: () => _realizaLogin(
                              context,
                              _controladorCampoEmail.text,
                              _controladorCampoSenha.text),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _redefinirSenha(String email) async {
    if (email.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Informar o e-mail no campo e-mail!!')));
    } else {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('E-mail enviado com sucesso ao seu e-mail')));
      });
    }
  }
}

void _realizarCadastro(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) =>  const Cadastro()));
}

Future<void> _realizaLogin(
    BuildContext context, String email, String senha) async {
  if (email.length < 2) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('E-mail não informado')));
  } else if (senha.length < 2) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Senha não informado')));
  } else {
    try {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => ListLogins()),
        (Route<dynamic> route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Não encontrado usuario')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Senha incorreta')));
      }
    }
  }
}
