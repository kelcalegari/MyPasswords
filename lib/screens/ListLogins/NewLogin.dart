// ignore_for_file: file_names, non_constant_identifier_names, must_be_immutable, no_logic_in_create_state

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codigo/models/LoginItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/Editor.dart';
import '../../components/InputCRCard.dart';

const List<IconData> list = <IconData>[
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
IconData iconValue = list.elementAt(0);

const _tituloAppBar = 'Novo Login';

const _rotuloCampoTitulo = 'Título';
const _dicaCampoTitulo = 'Intagram';
const _rotuloCampoUrl = 'Site';
const _dicaCampoUrl = 'www.google.com';
const _rotuloCampoLogin = 'Login';
const _dicaCampoLogin = 'kelvynncalegari@hotmail.com';
const _rotuloCampoSenha = 'Senha';
const _dicaCampoSenha = 'N5%?:>DER0';
const _rotuloCampoPin = 'Pin';
const _dicaCampoPin = '1234';
const _rotuloCampoChave = 'Chave';
const _dicaCampoChave = '1234';
const _rotuloCampoCodRecuperacao = 'Códigos de recuperação';

const _textoBotaoSalvar = 'Salvar';

class NewLogin extends StatefulWidget {
  LoginItem login;
  NewLogin({Key? key, required this.login}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return NewLoginState(login);
  }
}

class NewLoginState extends State<NewLogin> {
  LoginItem login;
  final TextEditingController _controladorCampoTitulo = TextEditingController();
  final TextEditingController _controladorCampoUrl = TextEditingController();
  final TextEditingController _controladorCampoLogin = TextEditingController();
  final TextEditingController _controladorCampoSenha = TextEditingController();
  final TextEditingController _controladorCampoPin = TextEditingController();
  final TextEditingController _controladorCampoChave = TextEditingController();
  List<bool> isExpanded = [false, false, false, false];

  final List<TextEditingController> _controladorCampoCodRecuperacao =
      List<TextEditingController>.generate(
          10, (index) => TextEditingController());

  NewLoginState(this.login);
  @override
  Widget build(BuildContext context) {
    if (login.titulo != "") {
      iconValue = list.elementAt(login.icone);
      _controladorCampoTitulo.text = login.titulo;
      _controladorCampoUrl.text = login.url;
      _controladorCampoLogin.text = login.login;
      _controladorCampoSenha.text = login.senha;
      _controladorCampoPin.text = login.pin;
      _controladorCampoChave.text = login.chave;
      for (var i = 0; i < 10; i++) {
        _controladorCampoCodRecuperacao[i].text = login.codRecuperacao[i];
      }
    }
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: const Text(_tituloAppBar),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  const SizedBox(
                    height: 70,
                    width: 100,
                    child: Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: DropdownButtonIcons()),
                  ),
                  Expanded(
                    child: Editor(
                      controlador: _controladorCampoTitulo,
                      rotulo: _rotuloCampoTitulo,
                      dica: _dicaCampoTitulo,
                      textInputType: TextInputType.text,
                    ),
                  ),
                ],
              ),
              Editor(
                controlador: _controladorCampoLogin,
                rotulo: _rotuloCampoLogin,
                icone: Icons.account_circle_outlined,
                dica: _dicaCampoLogin,
                textInputType: TextInputType.emailAddress,
              ),
              Editor(
                controlador: _controladorCampoSenha,
                rotulo: _rotuloCampoSenha,
                icone: Icons.lock,
                dica: _dicaCampoSenha,
                textInputType: TextInputType.visiblePassword,
                senha: true,
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
                              padding: EdgeInsets.only(left: 16.0),
                              child: Text(
                                _rotuloCampoUrl,
                                textScaleFactor: 1.5,
                              ),
                            ),
                          ],
                        );
                      },
                      body: Editor(
                        controlador: _controladorCampoUrl,
                        dica: _dicaCampoUrl,
                        icone: Icons.web,
                        textInputType: TextInputType.url,
                      ),
                      isExpanded: isExpanded[0],
                    ),
                    ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return Row(
                          textDirection: TextDirection.ltr,
                          children: const <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 16.0),
                              child: Text(
                                _rotuloCampoPin,
                                textScaleFactor: 1.5,
                              ),
                            ),
                          ],
                        );
                      },
                      body: Editor(
                        controlador: _controladorCampoPin,
                        icone: Icons.lock,
                        dica: _dicaCampoPin,
                        textInputType: TextInputType.visiblePassword,
                        senha: true,
                      ),
                      isExpanded: isExpanded[1],
                    ),
                    ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return Row(
                          textDirection: TextDirection.ltr,
                          children: const <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 16.0),
                              child: Text(
                                _rotuloCampoChave,
                                textScaleFactor: 1.5,
                              ),
                            ),
                          ],
                        );
                      },
                      body: Editor(
                        controlador: _controladorCampoChave,
                        icone: Icons.lock,
                        dica: _dicaCampoChave,
                        textInputType: TextInputType.visiblePassword,
                        senha: true,
                      ),
                      isExpanded: isExpanded[2],
                    ),
                    ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return Row(
                          textDirection: TextDirection.ltr,
                          children: const <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 16.0),
                              child: Text(
                                _rotuloCampoCodRecuperacao,
                                textScaleFactor: 1.5,
                              ),
                            ),
                          ],
                        );
                      },
                      body: Column(
                        children: [
                          InputCRCard(_controladorCampoCodRecuperacao[0],
                              _controladorCampoCodRecuperacao[1]),
                          InputCRCard(_controladorCampoCodRecuperacao[2],
                              _controladorCampoCodRecuperacao[3]),
                          InputCRCard(_controladorCampoCodRecuperacao[4],
                              _controladorCampoCodRecuperacao[5]),
                          InputCRCard(_controladorCampoCodRecuperacao[6],
                              _controladorCampoCodRecuperacao[7]),
                          InputCRCard(_controladorCampoCodRecuperacao[8],
                              _controladorCampoCodRecuperacao[9]),
                        ],
                      ),
                      isExpanded: isExpanded[3],
                    )
                  ],
                  expansionCallback: (int item, bool status) {
                    setState(() {
                      isExpanded[item] = !isExpanded[item];
                    });
                  }),
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
                  onPressed: () => _salvarLoginItem(context),
                ),
              ),
            ],
          ),
        ));
  }

  void _salvarLoginItem(BuildContext context) {
    final String titulo = _controladorCampoTitulo.text;
    String loginText = _controladorCampoLogin.text;
    final String senha = _controladorCampoSenha.text;

    final String pin = _controladorCampoPin.text;
    final String chave = _controladorCampoChave.text;
    final String url = _controladorCampoUrl.text;

    final List<String> codRecuperacoes = [];

    if (titulo != "" && loginText != "" && senha != "") {
      login.icone = 0;
      login.titulo = titulo;
      login.login = loginText;
      login.senha = senha;

      login.pin = pin;
      login.chave = chave;
      login.url = url;
      login.setIcon(iconValue);
      for (var i = 0; i < 10; i++) {
        // ignore: unnecessary_null_comparison
        if (_controladorCampoCodRecuperacao[i] != null) {
          codRecuperacoes.add(_controladorCampoCodRecuperacao[i].text);
        } else {
          break;
        }
      }
      if (codRecuperacoes.isNotEmpty) {
        login.codRecuperacao = codRecuperacoes;
      }
      if (login.id.length < 2) {
        newLogin(login);
      } else {
        saveLogin(login);
      }
      login = LoginItem(codRecuperacao: []);

      _controladorCampoTitulo.text = "";
      _controladorCampoUrl.text = "";
      _controladorCampoLogin.text = "";
      _controladorCampoSenha.text = "";
      _controladorCampoPin.text = "";
      _controladorCampoChave.text = "";
      for (var i = 0; i < 10; i++) {
        _controladorCampoCodRecuperacao[i].text = "";
      }

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Campos título, login e senha obrigatoria!!')));
    }
  }
}

newLogin(LoginItem loginItem) {
  debugPrint("newLogin: $loginItem");
  try {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final newloginItemRef = FirebaseFirestore.instance.collection(uid!).doc();
    loginItem.id = newloginItemRef.id;
    newloginItemRef.set(loginItem.toFirestore());
  } catch (e) {
    debugPrint("Erro ao criar item");
  }
}

saveLogin(LoginItem loginItem) {
  debugPrint("saveLogin: $loginItem");
  try {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final newloginItemRef =
        FirebaseFirestore.instance.collection(uid!).doc(loginItem.id);
    newloginItemRef.set(loginItem.toFirestore());
  } catch (e) {
    debugPrint("Erro ao criar item");
  }
}

class DropdownButtonIcons extends StatefulWidget {
  const DropdownButtonIcons({super.key});

  @override
  State<DropdownButtonIcons> createState() => _DropdownButtonState();
}

class _DropdownButtonState extends State<DropdownButtonIcons> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<IconData>(
      value: iconValue,
      icon: const Icon(Icons.arrow_drop_down),
      onChanged: (IconData? value) {
        // This is called when the user selects an item.
        setState(() {
          iconValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<IconData>>((IconData value) {
        return DropdownMenuItem<IconData>(
          value: value,
          child: Icon(
            value,
            size: 60,
          ),
        );
      }).toList(),
    );
  }
}
