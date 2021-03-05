import 'dart:convert';

import 'package:admin_jury_pro/DesignForm/InputDeco_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_form/flutter_auth_form.dart';
import 'package:flutter_models/models/UserModel.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(ConnexionJury());
}

class ConnexionJury extends StatefulWidget {
  @override
  _ConnexionJuryState createState() => _ConnexionJuryState();
}

class _ConnexionJuryState extends State<ConnexionJury> {
  TextEditingController telephone = TextEditingController();

  Future getJury() async {
    var response = await http.get("http://172.31.239.223:8000/jury");
    if (response.statusCode == 200) {
    return json.decode(response.body);
    } else {
      return null;
    }
  }
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
                  bottom: 20.0,
                ),
                child: TextFormField(
                  // ignore: unnecessary_brace_in_string_interps
                  controller: telephone..text = "",
                  keyboardType: TextInputType.text,
                  decoration:
                      buildInputDecoration(Icons.text_format, "Telephone"),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Entrer Votre numéro de téléphone S\'il vous plait';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    //name = value;
                  },
                  
                ),
                
              ),


              FlatButton(
                  textColor: Colors.black,
                  color: Colors.orange[800],
                  onPressed: () {


                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ModifierJu ry(jury[i])));
                    getJury();
                  },
                  child: const Text('Modifier'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
