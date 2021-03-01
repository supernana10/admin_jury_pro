import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:admin_jury_pro/DesignForm/InputDeco_design.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ModifierJury extends StatefulWidget {
  dynamic dataObjetJury = {};
  //final int id;

  ModifierJury(dynamic data) {
    this.dataObjetJury = data;
  }
  /*const ModifierEvenement({
    Key key,
    this.id,
  }) : super(key: key);*/

  @override
  _ModifierJuryState createState() => _ModifierJuryState(dataObjetJury);
}

class _ModifierJuryState extends State<ModifierJury> {
  //int id ;
  dynamic jury;
  _ModifierJuryState(dynamic data) {
    this.jury = data;
    /*setState(() {
      this.evenement = evenement;
    });*/
    print(this.jury);
    // log('data: $evenement');
  }

  /* static final String uploadEndPoint =
      'http://localhost/upload_image/upload_image.php';
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';
 */
  /*  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  } */

  /* setStatus(String message) {
    setState(() {
      status = message;
    });
  } */

  /* startUpload() {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    upload(fileName);
  } */

  /* upload(String fileName) {
    http.post(uploadEndPoint, body: {
      "image": base64Image,
      "name": fileName,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error) {
      setStatus(error);
    });
  } */

  /* Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return CircleAvatar(
            radius: 80,
            backgroundColor: Colors.white,
            child: Image.file(
              snapshot.data,
              fit: BoxFit.cover,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            "Pas d'image sélectionner",
            textAlign: TextAlign.center,
          );
        }
      },
    );
  } */

  //TextController to read text entered in text field
  TextEditingController nom = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController telephone = new TextEditingController();
  //..text = evenement["evenementNom"];
  TextEditingController email = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  // ignore: missing_return
  Future<Map<String, dynamic>> editJury(BuildContext context, String nom,
      String code, String telephone, String email) async {
    final http.Response response = await http.post(
      'http://172.31.239.223:8000/jury/${jury["jury_id"]}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "jury_Nom": nom,
        "jury_code": code,
        "jury_telephone": telephone,
        "jury_email": email,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Alert(
        context: context,
        title: "Jury",
        desc: "Modifier avec success.",
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
      Navigator.of(context).pop();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception("Echec de la modification du jury.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modification d'un jury"),
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
                          controller: nom..text = jury["jury_nom"],
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
                          controller: code..text = jury["jury_code"],
                          keyboardType: TextInputType.text,
                          decoration: buildInputDecoration(
                              Icons.confirmation_number, "Code"),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Entrer le code';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            // = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, left: 10, right: 10),
                        child: TextFormField(
                          controller: telephone..text = jury["jury_telephone"],
                          keyboardType: TextInputType.text,
                          decoration: buildInputDecoration(
                              Icons.phone_iphone, "Telephone"),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Entrer votre numéro de téléphone';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            // = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, left: 10, right: 10),
                        child: TextFormField(
                          controller: email..text = jury["jury_email"],
                          keyboardType: TextInputType.text,
                          decoration: buildInputDecoration(Icons.mail, "Email"),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Entrer votre email';
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
                                    editJury(
                                      context,
                                      nom.text,
                                      code.text,
                                      telephone.text,
                                      email.text,
                                    );
                                  },
                                  child: Text("Modifier")),

                              /* RaisedButton(
                                color: Colors.orange,
                                onPressed: chooseImage,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    side: BorderSide(
                                        color: Colors.black, width: 2)),
                                textColor: Colors.white,
                                child: Text("Image"),
                              ),
                              RaisedButton(
                                color: Colors.green,
                                onPressed: startUpload,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    side: BorderSide(
                                        color: Colors.black, width: 2)),
                                textColor: Colors.white,
                                child: Text("upload"),
                              ), */
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
