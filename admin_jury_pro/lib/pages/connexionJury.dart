import 'package:flutter/material.dart';
import 'package:flutter_auth_form/flutter_auth_form.dart';
import 'package:flutter_models/models/UserModel.dart';

void main() {
  runApp(ConnexionJury());
}

class ConnexionJury extends StatefulWidget {
  @override
  _ConnexionJuryState createState() => _ConnexionJuryState();
}

class _ConnexionJuryState extends State<ConnexionJury> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFFF8C00),
          title: const Text('JURY'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 50.0,
                ),
                child: AuthForm(
                  title: 'Authentification',
                  buttonLabel: 'Connexion',
                  emailLabel: 'Entrez votre nom',
                  passwordLabel: 'Entrez votre numéro de téléphone',
                  onPressed: (UserModel userModel) async =>
                      print(userModel.toJson()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
