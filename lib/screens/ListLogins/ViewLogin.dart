// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codigo/models/LoginItem.dart';
import 'package:codigo/screens/ListLogins/NewLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../../components/TextCRCard.dart';
import '../../components/TextCard.dart';
import 'ListLogins.dart';

const String _textoBotaoEditar = "Editar";
const String _textoBotaoExcluir = "Excluir";

// ignore: must_be_immutable
class ViewLogin extends StatefulWidget {
  LoginItem login;

  ViewLogin(this.login, {super.key});

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return ViewLoginState(login);
  }
}

class ViewLoginState extends State<ViewLogin> {
  LoginItem login;
  bool isExpandedCOD = false;

  ViewLoginState(this.login);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(login.getIcon()),
              ),
              Text(login.titulo)
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextCard("Login", login.login),
              TextCard("Senha", login.senha),
              if (login.url != "") TextCard("Site", login.url),
              if (login.pin != "") TextCard("Pin", login.pin),
              if (login.chave != "") TextCard("Chave", login.chave),
              if (login.codRecuperacao[0] != "")
                ExpansionPanelList(
                    elevation: 0,
                    children: [
                      ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return Row(
                            textDirection: TextDirection.ltr,
                            children: const <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 16.0),
                                child: Text(
                                  "Códigos de recuperação",
                                  textScaleFactor: 1.5,
                                ),
                              ),
                            ],
                          );
                        },
                        body: Column(
                          children: [
                            if (login.codRecuperacao[0] != "")
                              TextCRCard(login.codRecuperacao[0],
                                  login.codRecuperacao[1]),
                            if (login.codRecuperacao[2] != "")
                              TextCRCard(login.codRecuperacao[2],
                                  login.codRecuperacao[3]),
                            if (login.codRecuperacao[4] != "")
                              TextCRCard(login.codRecuperacao[4],
                                  login.codRecuperacao[5]),
                            if (login.codRecuperacao[6] != "")
                              TextCRCard(login.codRecuperacao[6],
                                  login.codRecuperacao[7]),
                            if (login.codRecuperacao[8] != "")
                              TextCRCard(login.codRecuperacao[8],
                                  login.codRecuperacao[9]),
                          ],
                        ),
                        isExpanded: isExpandedCOD,
                      )
                    ],
                    expansionCallback: (int item, bool status) {
                      setState(() {
                        isExpandedCOD = !isExpandedCOD;
                      });
                    }),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ElevatedButton(
                            child: const SizedBox(
                              height: 30,
                              width: 130,
                              child: Center(
                                child: Text(_textoBotaoExcluir,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20)),
                              ),
                            ),
                            onPressed: () => _excluir(context, login),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ElevatedButton(
                            child: const SizedBox(
                              height: 30,
                              width: 130,
                              child: Center(
                                child: Text(_textoBotaoEditar,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20)),
                              ),
                            ),
                            onPressed: () => _editar(context, login),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void _editar(BuildContext context, LoginItem loginItem) {
    Navigator.push(context,
            MaterialPageRoute(builder: (context) => NewLogin(login: loginItem)))
        .then((value) => _atualizarElemento(context, loginItem));
  }

  void _excluir(BuildContext context, LoginItem loginItem) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Alerta'),
        content: const Text('Deseja excluir?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              final uid = FirebaseAuth.instance.currentUser?.uid;
              FirebaseFirestore.instance
                  .collection(uid!)
                  .doc(loginItem.id)
                  .delete()
                  .then(
                    (value) => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => ListLogins()),
                      (Route<dynamic> route) => false,
                    ),
                  );
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  _atualizarElemento(BuildContext context, LoginItem itemLogin) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final ref = FirebaseFirestore.instance
        .collection(uid!)
        .doc(itemLogin.id)
        .withConverter(
          fromFirestore: LoginItem.fromFirestore,
          toFirestore: (LoginItem loginItem, _) => loginItem.toFirestore(),
        );
    final docSnap = await ref.get();
    final newloginItem = docSnap.data();
    if (newloginItem != null) {
      setState(() {
        widget.login = newloginItem;
      });
    }
  }
}
