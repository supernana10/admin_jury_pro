import 'dart:async';
import 'dart:convert';

//import 'package:JuryPro/ajouterEvenements.dart';
//import 'package:JuryPro/modifierevenements.dart';
import 'package:admin_jury_pro/pages/ajouterJury.dart';

import 'package:admin_jury_pro/pages/modifierJury.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Jury extends StatefulWidget {
  @override
  _JuryState createState() => _JuryState();
}

class _JuryState extends State<Jury> {
  List jury;
  List evenements;

  String get uri => null;

  Future getJury() async {
    var response = await http.get("http://172.31.239.223:8000/jury");
    jury = json.decode(response.body);
    // print("Response : ");
    // print(data);
    setState(() {
      jury = jury;
    });
  }

  @override
  void initState() {
    super.initState();
    getJury();
  }

  Future deleteJury(uri) async {
    String _uri = uri;

    var request = http.Request(
        'POST', Uri.parse('http://172.31.239.223:8000/jury/delete/' + _uri));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print("succes");
    } else {
      print(response.reasonPhrase);
      print("echec");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Jury Pro"),
          backgroundColor: Colors.deepOrange,
        ),
        body: jury != null ? getDisplayDatas() : waitDatas());
  }

  Widget getDisplayDatas() {
    // print(data[0]);
    return ListView.builder(
      padding: EdgeInsets.all(20),
      itemCount: jury.length,
      itemBuilder: (BuildContext context, int i) {
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.how_to_vote),
                title: Text("${jury[i]["jury_nom_complet"]}"),
                subtitle: Text(
                  "Code:${jury[i]["code_id"]}",
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              /*  Image.network("https://picsum.photos/250?image=9",
                  fit: BoxFit.fill, loadingBuilder: (BuildContext context,
                      Widget child, ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                        : null,
                  ),
                );
              }), */
              /* Image.memory(
                Base64Codec().decode(jury[i]["evenementphoto"]),
                fit: BoxFit.fill,
              ), */
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Numéro de téléphone:${jury[i]["jury_telephone"]}",
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Email: ${jury[i]["jury_email"]}",
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              ButtonBar(alignment: MainAxisAlignment.end, children: [
                FlatButton(
                  textColor: Colors.black,
                  color: Colors.orange[800],
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => AjouterJury()));
                    getJury();
                  },
                  child: const Text('Ajouter'),
                ),
                FlatButton(
                  textColor: Colors.black,
                  color: Colors.orange[800],
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ModifierJury(jury[i])));
                    getJury();
                  },
                  child: const Text('Modifier'),
                ),
                FlatButton(
                  textColor: Colors.white,
                  color: Colors.black,
                  onPressed: () {
                    showCupertinoDialog(
                        context: context,
                        builder: (_) => CupertinoAlertDialog(
                              title: Text(
                                  "Etes-vous sûr de vouloir supprimer ce jury?"),
                              // content: Text(
                              //     "This is the content"),
                              actions: [
                                // Close the dialog
                                CupertinoButton(
                                  child: Text("OUI",
                                      style:
                                          TextStyle(color: Colors.orange[900])),
                                  onPressed: () {
                                    this.deleteJury(
                                        "${jury[i]["jury_id"]}".toString());
                                    print("${jury[i]["jury_id"]}".toString());
                                    Navigator.of(context).pop();
                                    setState(() {});
                                  },
                                ),
                                CupertinoButton(
                                    child: Text('NON',
                                        style: TextStyle(
                                            color: Colors.orange[900])),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    })
                              ],
                            ));
                    // Perform some action
                  },
                  child: const Text('Supprimer'),
                ),
              ]),
            ],
          ),
        );
      },
    );
  }

  Widget waitDatas() {
    return Center(
      child: Text("Chargement...",
          style: TextStyle(
            color: Colors.deepOrange,
          )),
    );
  }
}

/* import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'dart:developer' as developer;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: Evenements(),
  ));
}

class Evenements extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Evenements> {
  List data;
  List evenements;

  Future getData() async {
    http.Response response =
        await http.get("http://172.31.239.223:8000/evenements");
    data = json.decode(response.body);
    // print("Response : ");
    // print(data);
    setState(() {
      data = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Evènements"),
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.event),
                  title: Text("${data[index]["evenementNom"]}"),
                  subtitle: Text(
                    "Evenement de ${data[index]["evenementType"]}",
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Image.network(
                    "https://cdn.pixabay.com/photo/2014/05/02/21/50/laptop-336378_1280.jpg",
                    fit: BoxFit.fill, loadingBuilder: (BuildContext context,
                        Widget child, ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes
                          : null,
                    ),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Début:${data[index]["evenementDateDebut"]} / Fin:${data[index]["evenementDateDebut"]}",
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                ButtonBar(alignment: MainAxisAlignment.center, children: [
                  FlatButton(
                    textColor: Colors.blueAccent,
                    color: Colors.orange,
                    onPressed: () {
                      // Perform some action
                    },
                    child: const Text(
                      'En Savoir +',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ]),
              ],
            ),
          );
        },
      ),
    );
  }
}
 */
