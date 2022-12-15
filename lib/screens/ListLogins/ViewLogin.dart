import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codigo/models/LoginItem.dart';
import 'package:codigo/screens/ListLogins/NewLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ListLogins.dart';

const String _textoBotaoEditar = "Editar";
const String _textoBotaoExcluir = "Excluir";

class ViewLogin extends StatefulWidget {
  LoginItem login;
  ViewLogin(this.login);
  @override
  State<StatefulWidget> createState() {
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
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: Row(
            children: [Padding(padding: EdgeInsets.only(right: 10),
            child: Icon(login.getIcon()),),
              Text(login.titulo)],
          ) ,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Login: ${widget.login.login}",
                  textAlign: TextAlign.right,
                  textScaleFactor: 1.5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Senha: ${widget.login.senha}",
                  textAlign: TextAlign.right,
                  textScaleFactor: 1.5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Site: ${widget.login.url}",
                  textAlign: TextAlign.right,
                  textScaleFactor: 1.5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Pin: ${widget.login.pin}",
                  textAlign: TextAlign.right,
                  textScaleFactor: 1.5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Chave: ${widget.login.chave}",
                  textAlign: TextAlign.right,
                  textScaleFactor: 1.5,
                ),
              ),
              ExpansionPanelList(
                  elevation: 0,
                  children: [
                    ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return Row(
                          textDirection: TextDirection.ltr,
                          children: const <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 50.0),
                              child: Text("Códigos de recuperação",
                                textScaleFactor: 1.5,),
                            ),
                          ],
                        );
                      },
                      body: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Text(
                                  widget.login.codRecuperacao[0],
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1.5,
                                )),
                                Expanded(
                                    child: Text(
                                  widget.login.codRecuperacao[1],
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1.5,
                                )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Text(
                                  widget.login.codRecuperacao[2],
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1.5,
                                )),
                                Expanded(
                                    child: Text(
                                  widget.login.codRecuperacao[3],
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1.5,
                                )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Text(
                                  widget.login.codRecuperacao[4],
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1.5,
                                )),
                                Expanded(
                                    child: Text(
                                  widget.login.codRecuperacao[5],
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1.5,
                                )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Text(
                                  widget.login.codRecuperacao[6],
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1.5,
                                )),
                                Expanded(
                                    child: Text(
                                  widget.login.codRecuperacao[7],
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1.5,
                                )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Text(
                                  widget.login.codRecuperacao[8],
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1.5,
                                )),
                                Expanded(
                                    child: Text(
                                  widget.login.codRecuperacao[9],
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1.5,
                                )),
                              ],
                            ),
                          ),
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
                        child: ElevatedButton(
                          child: Text(_textoBotaoExcluir),
                          onPressed: () => _excluir(context, widget.login),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: ElevatedButton(
                          child: Text(_textoBotaoEditar),
                          onPressed: () => _editar(context, widget.login),
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
              final ref = FirebaseFirestore.instance
                  .collection(uid!)
                  .doc(loginItem.id)
                  .delete();
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context)=>  ListLogins()),
                    (Route<dynamic> route) => false,);
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
