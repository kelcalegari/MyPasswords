import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codigo/models/LoginItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/editor.dart';

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

LoginItem login = LoginItem(codRecuperacao: []);

class NewLogin extends StatefulWidget {
  
  NewLogin({Key? key, required login}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return NewLoginState();
  }
}

class NewLoginState extends State<NewLogin> {
  
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

  NewLoginState();
  @override
  Widget build(BuildContext context) {
    

    if (login.icone != null) {
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
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: Text(_tituloAppBar),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    height: 70,
                    width: 100,
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: DropdownButtonIcons()),),
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
                        rotulo: _rotuloCampoUrl,
                        dica: _dicaCampoUrl,
                        icone: Icons.alternate_email_outlined,
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
                        rotulo: _rotuloCampoPin,
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
                        rotulo: _rotuloCampoChave,
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
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Editor(
                                  controlador:
                                      _controladorCampoCodRecuperacao[0],
                                  textInputType: TextInputType.visiblePassword,
                                ),
                              ),
                              Expanded(
                                child: Editor(
                                  controlador:
                                      _controladorCampoCodRecuperacao[1],
                                  textInputType: TextInputType.visiblePassword,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Editor(
                                  controlador:
                                      _controladorCampoCodRecuperacao[2],
                                  textInputType: TextInputType.visiblePassword,
                                ),
                              ),
                              Expanded(
                                child: Editor(
                                  controlador:
                                      _controladorCampoCodRecuperacao[3],
                                  textInputType: TextInputType.visiblePassword,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Editor(
                                  controlador:
                                      _controladorCampoCodRecuperacao[4],
                                  textInputType: TextInputType.visiblePassword,
                                ),
                              ),
                              Expanded(
                                child: Editor(
                                  controlador:
                                      _controladorCampoCodRecuperacao[5],
                                  textInputType: TextInputType.visiblePassword,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Editor(
                                  controlador:
                                      _controladorCampoCodRecuperacao[6],
                                  textInputType: TextInputType.visiblePassword,
                                ),
                              ),
                              Expanded(
                                child: Editor(
                                  controlador:
                                      _controladorCampoCodRecuperacao[7],
                                  textInputType: TextInputType.visiblePassword,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Editor(
                                  controlador:
                                      _controladorCampoCodRecuperacao[8],
                                  textInputType: TextInputType.visiblePassword,
                                ),
                              ),
                              Expanded(
                                child: Editor(
                                  controlador:
                                      _controladorCampoCodRecuperacao[9],
                                  textInputType: TextInputType.visiblePassword,
                                ),
                              ),
                            ],
                          ),
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
              ElevatedButton(
                child: Text(_textoBotaoSalvar),
                onPressed: () => _salvarLoginItem(context, login),
              ),
            ],
          ),
        ));
  }

  void _salvarLoginItem(BuildContext context, LoginItem loginItem) {
    final String titulo = _controladorCampoTitulo.text;
    final String login = _controladorCampoLogin.text;
    final String senha = _controladorCampoSenha.text;

    final String pin = _controladorCampoPin.text;
    final String chave = _controladorCampoChave.text;
    final String url = _controladorCampoUrl.text;

    final List<String> codRecuperacoes = [];

    if (titulo != "" && login != "" && senha != "") {
      loginItem.icone = 0;
      loginItem.titulo = titulo;
      loginItem.login = login;
      loginItem.senha = senha;

      if (pin != null) {
        loginItem.pin = pin;
      }
      if (chave != null) {
        loginItem.chave = chave;
      }
      if (url != null) {
        loginItem.url = url;
      }
      loginItem.setIcon(IconValue);
      for (var i = 0; i < 10; i++) {
        if (_controladorCampoCodRecuperacao[i] != null) {
          codRecuperacoes.add(_controladorCampoCodRecuperacao[i].text);
        } else {
          break;
        }
      }
      if (!codRecuperacoes.isEmpty) {
        loginItem.codRecuperacao = codRecuperacoes;
      }
      if (loginItem.id.length < 2) {
        newLogin(loginItem);
      } else {
        saveLogin(loginItem);
      }

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Campos título, login e senha obrigatoria!!')));
    }
  }
}

newLogin(LoginItem loginItem) {
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
  try {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final newloginItemRef =
        FirebaseFirestore.instance.collection(uid!).doc(loginItem.id);
    newloginItemRef.set(loginItem.toFirestore());
  } catch (e) {
    debugPrint("Erro ao criar item");
  }
}

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
IconData IconValue = list.elementAt(login.icone);
class DropdownButtonIcons extends StatefulWidget {
  const DropdownButtonIcons({super.key});

  @override
  State<DropdownButtonIcons> createState() => _DropdownButtonState();
}

class _DropdownButtonState extends State<DropdownButtonIcons> {


  @override
  Widget build(BuildContext context) {
    return DropdownButton<IconData>(
      value: IconValue,
      icon: const Icon(Icons.arrow_drop_down),

      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (IconData? value) {
        // This is called when the user selects an item.
        setState(() {
          IconValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<IconData>>((IconData value) {
        return DropdownMenuItem<IconData>(
          value: value,
          child: Icon(value,size: 60,),
        );
      }).toList(),
    );
  }
}
