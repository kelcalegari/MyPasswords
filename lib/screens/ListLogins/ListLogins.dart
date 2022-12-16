// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codigo/screens/ListLogins/NewLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/CardLogin.dart';
import '../../models/LoginItem.dart';

const _tituloAppBar = 'Logins';

// ignore: must_be_immutable
class ListLogins extends StatefulWidget {
  List<LoginItem> _loginItens = [];

  ListLogins({super.key});

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
  void dispose() {
    super.dispose();
    getListOfLogins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_tituloAppBar),
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
      debugPrint("getListOfLogins");
      widget._loginItens.clear();
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
