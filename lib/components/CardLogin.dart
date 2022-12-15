// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/LoginItem.dart';
import '../screens/ListLogins/ViewLogin.dart';

class CardLogin extends StatefulWidget {
  final LoginItem _novoLogin;

  const CardLogin(this._novoLogin, {super.key});

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return CardLoginState(_novoLogin);
  }
}

class CardLoginState extends State<CardLogin> {
  LoginItem novoLogin;

  CardLoginState(this.novoLogin);
  _visualizarLogin(BuildContext context, LoginItem itemLogin) {
    Navigator.push(context,
            MaterialPageRoute(builder: (context) => ViewLogin(itemLogin)))
        .then((value) {
      super.setState(() {
        super.didChangeDependencies();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _visualizarLogin(context, novoLogin),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListTile(
            leading: Icon(novoLogin.getIcon(),size: 40,),
            title: Text(novoLogin.titulo),
            subtitle:
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(children: [
                GestureDetector(
                  onLongPress: () {
                    Clipboard.setData(ClipboardData(text: novoLogin.login));
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$novoLogin.login Copiado!!')));
                  },
                  child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 5),
                      child: Text(novoLogin.login)),
                ),
                GestureDetector(
                  onLongPress: () {
                    Clipboard.setData(ClipboardData(text: novoLogin.senha));
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$novoLogin.senha Copiado!!')));
                  },
                  child: Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 10),
                      child: Text(novoLogin.senha)),
                )
              ]),
            ]),
          ),
        ),
      ),
    );
  }
}
