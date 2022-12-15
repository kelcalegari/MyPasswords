import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codigo/screens/ListLogins/NewLogin.dart';
import 'package:codigo/screens/ListLogins/ViewLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/LoginItem.dart';

const _tituloAppBar = 'Logins';

class ListLogins extends StatefulWidget {
  List<LoginItem> _loginItens = [];

  ListLogins();

  @override
  State<StatefulWidget> createState() {
    return ListLoginsState();
  }
}

class ListLoginsState extends State<ListLogins> {
  ListLoginsState();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getListOfLogins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: ListView.builder(
        itemCount: widget._loginItens.length,
        itemBuilder: (context, index) {
          return CardLogin(widget._loginItens.elementAt(index));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return NewLogin(login: LoginItem(codRecuperacao: []));
          })).then((value) => getListOfLogins());
        },
      ),
    );
  }

  Future getListOfLogins() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      var data = await FirebaseFirestore.instance
          .collection(uid!)
          .orderBy('titulo')
          .get();
      setState(() {
        widget._loginItens =
            List.from(data.docs.map((doc) => LoginItem.fromListFirestore(doc)));
      });
    } catch (e) {
      debugPrint("Erro ao listar item erro: $e");
    }
  }
}

class CardLogin extends StatefulWidget {
  final LoginItem _novoLogin;

  CardLogin(this._novoLogin);

  @override
  State<StatefulWidget> createState() {
    return CardLoginState(_novoLogin);
  }
}

class CardLoginState extends State<CardLogin> {
  LoginItem _novoLogin;

  CardLoginState(this._novoLogin);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _visualizarLogin(context, _novoLogin),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListTile(
            leading: Icon(_novoLogin.getIcon()),
            title: Text(_novoLogin.titulo),
            subtitle:
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(children: [
                GestureDetector(
                  onLongPress: () {
                    Clipboard.setData(ClipboardData(text: _novoLogin.login));
                  },
                  child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 5),
                      child: Text(_novoLogin.login)),
                ),
                GestureDetector(
                  onLongPress: () {
                    Clipboard.setData(ClipboardData(text: _novoLogin.senha));
                  },
                  child: Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 10),
                      child: Text(_novoLogin.senha)),
                )
              ]),
            ]),
          ),
        ),
      ),
    );
  }

  _visualizarLogin(BuildContext context, LoginItem itemLogin) {
    debugPrint("_visualizarLogin= " + itemLogin.toString());
    Navigator.push(context,
            MaterialPageRoute(builder: (context) => ViewLogin(itemLogin)))
        .then((value) {
      super.setState(() {
        super.didChangeDependencies();
      });
    });
  }
}
