import 'package:codigo/screens/ListLogins/ListLogins.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    final email = FirebaseAuth.instance.currentUser?.email;
    if (email != null){
      _controladorCampoEmail.text=email;
    }
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
              onPressed: () => _realizaLogin(context, _controladorCampoEmail.text,_controladorCampoSenha.text),
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


Future<void> _realizaLogin(BuildContext context, String email, String senha) async {


  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: senha
    );
    Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context)=>  ListLogins()),
          (Route<dynamic> route) => false,);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Não encontrado usuario')));
    } else if (e.code == 'wrong-password') {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Senha incorreta')));
    }
  }

}



void alerta (BuildContext context, String mensagem) {
  debugPrint("Alerta " + mensagem);
  AlertDialog alerta = AlertDialog(
    title: Text("Alerta"),
    content: Text(mensagem),);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}