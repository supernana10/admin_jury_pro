import 'dart:async';
import 'dart:convert';

//import 'package:GroupesPro/ajouterEvenements.dart';
//import 'package:GroupesPro/modifierevenements.dart';
import 'package:admin_jury_pro/pages/ajouterGroupes.dart';
import 'package:admin_jury_pro/pages/modifierGroupes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Groupes extends StatefulWidget {
  @override
  _GroupesState createState() => _GroupesState();
}

class _GroupesState extends State<Groupes> {
  List groupe;
  List evenements;

  String get uri => null;

  Future getGroupe() async {
    var response = await http.get("http://172.31.239.223:8000/groupes");
    groupe = json.decode(response.body);
    // print("Response : ");
    // print(data);
    setState(() {
      groupe = groupe;
    });
  }

  @override
  void initState() {
    super.initState();
    getGroupe();
  }

  Future deleteGroupes(uri) async {
    String _uri = uri;

    var request = http.Request(
        'POST', Uri.parse('http://172.31.239.223:8000/groupes/delete/' + _uri));
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
        body: groupe != null ? getDisplayDatas() : waitDatas());
  }

  Widget getDisplayDatas() {
    // print(data[0]);
    return ListView.builder(
      padding: EdgeInsets.all(20),
      itemCount: groupe.length,
      itemBuilder: (BuildContext context, int i) {
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.how_to_vote),
                title: Text("${groupe[i]["groupe_nom"]}"),
                subtitle: Text(
                  "Code:${groupe[i]["code_id"]}",
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
              }),  */
              Image.memory(
                Base64Codec().decode(groupe[i]["groupe_photo"]),
                fit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Numéro de téléphone:${groupe[i]["groupe_telephone"]}",
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
                            builder: (BuildContext context) =>
                                AjouterGroupes()));
                    getGroupe();
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
                                ModifierGroupes(groupe[i])));
                    getGroupe();
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
                                  "Etes-vous sûr de vouloir supprimer ce groupe?"),
                              // content: Text(
                              //     "This is the content"),
                              actions: [
                                // Close the dialog
                                CupertinoButton(
                                  child: Text("OUI",
                                      style:
                                          TextStyle(color: Colors.orange[900])),
                                  onPressed: () {
                                    this.deleteGroupes(
                                        "${groupe[i]["groupe_id"]}".toString());
                                    print("${groupe[i]["groupe_id"]}".toString());
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
