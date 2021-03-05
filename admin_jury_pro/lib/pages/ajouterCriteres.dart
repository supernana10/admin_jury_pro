import 'package:admin_jury_pro/DesignForm/InputDeco_design.dart';
import 'package:admin_jury_pro/pages/criteres.dart';
import 'package:flutter/material.dart';
//import 'package:CriteresPro/evenements.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

class AjouterCriteres extends StatefulWidget {
  @override
  _AjouterCriteresState createState() => _AjouterCriteresState();
}

class _AjouterCriteresState extends State<AjouterCriteres> {
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
  TextEditingController libelle= TextEditingController();
  TextEditingController bareme= TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  // ignore: missing_return
  Future<Map<String, dynamic>> addCriteres(
    BuildContext context,
    String libelle,
    String bareme,
    
  ) async {
    // print(base64Image);
    final http.Response response = await http.post(
      'http://172.31.239.223:8000/criteres',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "criteres_libelle": libelle,
        "criteres_bareme": bareme,
      }),
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Alert(
        context: context,
        title: "Criteres",
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
      print("Echec de l'ajout du criteres");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajout d'un critere"),
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
                          controller: libelle,
                          keyboardType: TextInputType.text,
                          decoration: buildInputDecoration(Icons.text_format, "Libelle"),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Entrer le libelle S\'il vous plait';
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
                          controller: bareme,
                          keyboardType: TextInputType.text,
                          decoration: buildInputDecoration(Icons.markunread_sharp, "Bareme"),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Entrer le bareme S\'il vous plait';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            //email = value;
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
                                  addCriteres(
                                    context,
                                    libelle.text,
                                    bareme.text,
                                    
                                  );
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Criteres()));
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
