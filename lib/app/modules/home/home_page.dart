import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/app/core/fire_auth.dart';
import 'package:flutter_firebase/app/core/validator.dart';
import 'package:flutter_firebase/app/modules/home/home_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeStore store = Modular.get();

  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SafeArea(
        child: Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: controllerEmail,
                    decoration: const InputDecoration(label: Text('E-mail')),
                    validator: (value) =>
                        Validator.validateEmail(email: value!),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controllerSenha,
                    obscureText: true,
                    decoration: const InputDecoration(label: Text('E-mail')),
                    validator: (value) =>
                        Validator.validatePassword(password: value!),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              User? user =
                                  await FireAuth.signInUsingEmailPassword(
                                email: controllerEmail.text,
                                password: controllerSenha.text,
                                context: context,
                              );
                              if (user != null) {
                                showDialog(
                                    context: context,
                                    builder: (context) => const AlertDialog(
                                          title: Text('Sucesso'),
                                          content: Text(
                                              'Usuário Logado com sucesso'),
                                        ));
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) => const AlertDialog(
                                          title: Text('Erro'),
                                          content: Text('Usuário Não logado'),
                                        ));
                              }
                            }
                          },
                          child: const Text('Login')),
                      TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              User? user =
                                  await FireAuth.registerUsingEmailPassword(
                                      email: controllerEmail.text,
                                      password: controllerSenha.text,
                                      name: 'Victor Bores Pereira');
                              if (user != null) {
                                showDialog(
                                    context: context,
                                    builder: (context) => const AlertDialog(
                                          title: Text('Sucesso'),
                                          content: Text(
                                              'Usuário Registrado com sucesso'),
                                        ));
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) => const AlertDialog(
                                          title: Text('Erro'),
                                          content:
                                              Text('Usuário Não Registrado'),
                                        ));
                              }
                            }
                          },
                          child: const Text('Registro')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
