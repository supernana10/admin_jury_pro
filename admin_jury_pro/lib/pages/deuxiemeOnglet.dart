import 'dart:convert';
import 'package:admin_jury_pro/pages/ajouterJury.dart';
import 'package:admin_jury_pro/pages/entity/candidat.dart';
import 'package:admin_jury_pro/pages/modifierJury.dart';
import 'package:admin_jury_pro/pages/old.dart/ajouterCandidats.dart';
import 'package:admin_jury_pro/pages/old.dart/modifierCandidats.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';

class Example1 extends StatefulWidget {
  int evenement;

  Example1({Key key, this.evenement}) : super(key: key);

  @override
  _Example1State createState() => _Example1State(evenement);
}

class _Example1State extends State<Example1> {
  List candidats;
  List groupes = [];
  List jury = [];
  List datas;
  List evenements;
  int evenement;

  String get uri => null;
  Future futureCandidat;
  Future futureJury;

  _Example1State(int evenement) {
    this.evenement = evenement;
  }

  Future getData() async {
    var response = await http
        .get("http://172.31.239.223:8000/candidats/evenements/$evenement");

    if (response.statusCode == 200) {
      setState(() {
        candidats = json.decode(response.body);
      });
    } else {
      throw Exception("Erreur de récupération des candidats");
    }
    // print("Response : ");
    // print(data);
  }

  Future getDatas() async {
    var response =
        await http.get("http://172.31.239.223:8000/jury/evenements/$evenement");

    if (response.statusCode == 200) {
      setState(() {
        jury = json.decode(response.body);
      });
    } else {
      throw Exception("Erreur de récupération du jury");
    }
    // print("Response : ");
    // print(data);
  }

  @override
  void initState() {
    super.initState();
    getData();
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

  Future deleteCandidats(uri) async {
    String _uri = uri;

    var request = http.Request('POST',
        Uri.parse('http://172.31.239.223:8000/candidats/delete/' + _uri));
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
      body: SafeArea(
        child: DefaultTabController(
          length: 4,
          child: Column(
            children: <Widget>[
              ButtonsTabBar(
                backgroundColor: Colors.red,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: TextStyle(color: Colors.black),
                labelStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: [
                  Tab(
                    icon: Icon(Icons.person),
                    text: "candidat",
                  ),
                  Tab(
                    icon: Icon(Icons.people),
                    text: "groupe",
                  ),
                  Tab(
                    icon: Icon(Icons.how_to_vote),
                    text: "jury",
                  ),
                  Tab(
                    icon: Icon(Icons.mark_as_unread),
                    text: "critères",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    ListView.builder(
                      padding: EdgeInsets.all(20),
                      itemCount: (candidats.isEmpty) ? 0 : candidats.length,
                      itemBuilder: (BuildContext context, int i) {
                        return Card(
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(Icons.person),
                                title: Text("${candidats[i]["candidat_nom"]}"),
                                subtitle: Text(
                                  "Code du candidat ${candidats[i]["candidat_code"]}",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                              ),
                              Image.memory(
                                Base64Codec()
                                    .decode(candidats[i]["candidat_photo"]),
                                fit: BoxFit.fill,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "Email:${candidats[i]["candidat_email"]}",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "Numéro de téléphone: ${candidats[i]["candidat"]}",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                              ),
                              ButtonBar(
                                  alignment: MainAxisAlignment.end,
                                  children: [
                                    FlatButton(
                                      textColor: Colors.black,
                                      color: Colors.orange[800],
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        AjouterCandidat()));
                                        getData();
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
                                                builder:
                                                    (BuildContext context) =>
                                                        ModifierCandidat(
                                                            candidats[i])));
                                        getData();
                                      },
                                      child: const Text('Modifier'),
                                    ),
                                    FlatButton(
                                      textColor: Colors.white,
                                      color: Colors.black,
                                      onPressed: () {
                                        showCupertinoDialog(
                                            context: context,
                                            builder: (_) =>
                                                CupertinoAlertDialog(
                                                  title: Text(
                                                      "Etes-vous sûr de vouloir supprimer ce candidat?"),
                                                  // content: Text(
                                                  //     "This is the content"),
                                                  actions: [
                                                    // Close the dialog
                                                    CupertinoButton(
                                                      child: Text("OUI",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.orange[
                                                                      900])),
                                                      onPressed: () {
                                                        this.deleteCandidats(
                                                            "${candidats[i]["candidats_id"]}"
                                                                .toString());
                                                        print(
                                                            "${candidats[i]["candidats_id"]}"
                                                                .toString());
                                                        Navigator.of(context)
                                                            .pop();
                                                        setState(() {});
                                                      },
                                                    ),
                                                    CupertinoButton(
                                                        child: Text('NON',
                                                            style: TextStyle(
                                                                color: Colors
                                                                        .orange[
                                                                    900])),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
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
                    ),
                    Center(),
                    Center(
                      child: TabBarView(children: <Widget>[
                        ListView.builder(
                          padding: EdgeInsets.all(20),
                          itemCount: (jury.isEmpty) ? 0 : jury.length,
                          itemBuilder: (BuildContext context, int i) {
                            return Card(
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.how_to_vote),
                                    title:
                                        Text("${datas[i]["jury_nom_complet"]}"),
                                    subtitle: Text(
                                      "Code:${datas[i]["code_id"]}",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      "Numéro de téléphone:${datas[i]["jury_telephone"]}",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      "Email: ${datas[i]["jury_email"]}",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                  ),
                                  ButtonBar(
                                      alignment: MainAxisAlignment.end,
                                      children: [
                                        FlatButton(
                                          textColor: Colors.black,
                                          color: Colors.orange[800],
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        AjouterJury()));
                                            getDatas();
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
                                                    builder: (BuildContext
                                                            context) =>
                                                        ModifierJury(
                                                            datas[i])));
                                            getDatas();
                                          },
                                          child: const Text('Modifier'),
                                        ),
                                        FlatButton(
                                          textColor: Colors.white,
                                          color: Colors.black,
                                          onPressed: () {
                                            showCupertinoDialog(
                                                context: context,
                                                builder:
                                                    (_) => CupertinoAlertDialog(
                                                          title: Text(
                                                              "Etes-vous sûr de vouloir supprimer ce jury?"),
                                                          // content: Text(
                                                          //     "This is the content"),
                                                          actions: [
                                                            // Close the dialog
                                                            CupertinoButton(
                                                              child: Text("OUI",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                              .orange[
                                                                          900])),
                                                              onPressed: () {
                                                                this.deleteJury(
                                                                    "${datas[i]["jury_id"]}"
                                                                        .toString());
                                                                print("${datas[i]["jury_id"]}"
                                                                    .toString());
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                setState(() {});
                                                              },
                                                            ),
                                                            CupertinoButton(
                                                                child: Text(
                                                                    'NON',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .orange[900])),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
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
                        )
                      ]),
                    ),
                    Center(
                      child: Icon(Icons.mark_as_unread),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
