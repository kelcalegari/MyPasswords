// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginItem {
  String id;
  int icone;
  String titulo;
  String url;
  String login;
  String senha;
  String pin;
  String chave;
  List<IconData> iconList = <IconData>[
    Icons.email,
    Icons.apple,
    Icons.badge,
    Icons.adobe,
    Icons.all_inbox,
    Icons.alternate_email,
    Icons.analytics,
    Icons.chat,
    Icons.cloud
  ];
  List<String> codRecuperacao;

  LoginItem(
      {this.icone = 0,
      this.titulo = "",
      this.login = "",
      this.senha = "",
      this.url = "",
      this.pin = "",
      this.chave = "",
      required this.codRecuperacao,
      this.id = ""}) {
    var i = codRecuperacao.length;
    for (; i < 10; i++) {
      codRecuperacao.add("");
    }
  }
  IconData getIcon() {
    return iconList.elementAt(icone);
  }

  setIcon(IconData element) {
    icone = iconList.indexOf(element);
  }

  @override
  String toString() {
    return 'LoginItem{titulo: $titulo, login: $login, senha: $senha}';
  }

  factory LoginItem.fromListFirestore(snapshot) {
    final data = snapshot.data();
    final icone = data?['icone'];
    debugPrint("icone = $icone");
    return LoginItem(
      id: data?['id'],
      icone: icone,
      titulo: data?['titulo'],
      url: data?['url'],
      login: data?['login'],
      senha: data?['senha'],
      pin: data?['pin'],
      chave: data?['chave'],
      codRecuperacao: data!['codRecuperacao'] is Iterable
          ? List.from(data['codRecuperacao'])
          : [],
    );
  }

  factory LoginItem.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return LoginItem(
      id: data?['id'],
      icone: data?['icone'],
      titulo: data?['titulo'],
      url: data?['url'],
      login: data?['login'],
      senha: data?['senha'],
      pin: data?['pin'],
      chave: data?['chave'],
      codRecuperacao: data!['codRecuperacao'] is Iterable
          ? List.from(data['codRecuperacao'])
          : [],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "titulo": titulo,
      "icone": icone,
      "url": url,
      "login": login,
      "senha": senha,
      "pin": pin,
      "chave": chave,
      "codRecuperacao": codRecuperacao,
    };
  }
}
