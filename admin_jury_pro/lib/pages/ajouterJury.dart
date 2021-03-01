import 'package:admin_jury_pro/DesignForm/InputDeco_design.dart';
import 'package:admin_jury_pro/pages/jury.dart';
import 'package:flutter/material.dart';
//import 'package:JuryPro/evenements.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

class AjouterJury extends StatefulWidget {
  @override
  _AjouterJuryState createState() => _AjouterJuryState();
}

class _AjouterJuryState extends State<AjouterJury> {
  static final String uploadEndPoint = '';
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  /* chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload() {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    upload(fileName);
  }

  upload(String fileName) {
    http.post(uploadEndPoint, body: {
      "image": base64Image,
      "name": fileName,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error) {
      setStatus(error);
    });
  }
 */

  //TextController to read text entered in text field
  TextEditingController nom = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController telephone = TextEditingController();
  TextEditingController email = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  // ignore: missing_return
  Future<Map<String, dynamic>> addJury(
    BuildContext context,
    String nom,
    String code,
    String telephone,
    String email,
  ) async {
    // print(base64Image);
    final http.Response response = await http.post(
      'http://172.31.239.223:8000/jury',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "jury_nom": nom,
        "jury_code": code,
        "jury_telephone": telephone,
        "jury_email": email,
      }),
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Alert(
        context: context,
        title: "Jury",
        desc: "Ajouter avec success.",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
      //Navigator.of(context).pop();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print("Echec de l'ajout du jury");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajout d'un jury"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    children: [
                      //showImage(),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, left: 10, right: 10, top: 20),
                        child: TextFormField(
                          // ignore: unnecessary_brace_in_string_interps
                          //initialValue: Text(papa.data.evenementNom),
                          controller: nom,
                          keyboardType: TextInputType.text,
                          decoration: buildInputDecoration(Icons.person, "Nom"),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Entrer Votre nom S\'il vous plait';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            //name = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, left: 10, right: 10),
                        child: TextFormField(
                          controller: code,
                          keyboardType: TextInputType.text,
                          decoration: buildInputDecoration(Icons.code, "Code"),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Entrer votre code S\'il vous plait';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            //email = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, left: 10, right: 10),
                        child: TextFormField(
                          controller: telephone,
                          keyboardType: TextInputType.text,
                          decoration: buildInputDecoration(
                              Icons.phone_iphone, "Telephone"),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Entrer votre numéro de téléphone S\'il vous plait';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, left: 10, right: 10),
                        child: TextFormField(
                          controller: email,
                          keyboardType: TextInputType.text,
                          decoration:
                              buildInputDecoration(Icons.email, "Email"),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Entrer votre mail S\'il vous plait';
                            }
                            return null;
                          },
                        ),
                      ),

                      SizedBox(
                          width: 600,
                          height: 50,
                          child: Row(
                            children: [
                              RaisedButton(
                                color: Colors.orange,
                                onPressed: () {
                                  addJury(
                                    context,
                                    nom.text,
                                    code.text,
                                    email.text,
                                    telephone.text,
                                  );
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Jury()));
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    side: BorderSide(
                                        color: Colors.black, width: 2)),
                                textColor: Colors.white,
                                child: Text("Ajouter"),
                              ),
                            ],
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
