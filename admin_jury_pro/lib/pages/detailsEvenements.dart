import 'package:admin_jury_pro/pages/old.dart/ajouterCandidats.dart';
import 'package:admin_jury_pro/pages/old.dart/modifierCandidats.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailsEvenements extends StatefulWidget {
  const DetailsEvenements({Key key, this.evenementid}) : super(key: key);

  final int evenementid;
  @override
  State<StatefulWidget> createState() {}
}

class _DetailsEvenementsState extends State<DetailsEvenements> {
  _ReadEventState(int evenementid) {
    evenementid = evenementid == null ? null : evenementid;
  }

  int evenementid;
  Future<List> candidatById() async {
    var response = await http
        .get("http://172.31.239.223:8000/candidats/evenements/$evenementid");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Erreur de récupération des candidats");
    }
    // print("Response : ");
    // print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: DefaultTabController(
                length: 4,
                child: Column(children: <Widget>[
                  ButtonsTabBar(
                    backgroundColor: Colors.red,
                    unselectedBackgroundColor: Colors.grey[300],
                    unselectedLabelStyle: TextStyle(color: Colors.black),
                    labelStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
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
                      child: TabBarView(children: <Widget>[
                    FutureBuilder(
                      future: candidatById(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            padding: EdgeInsets.all(20),
                            itemCount: snapshot.data.length,
                                
                            itemBuilder: (BuildContext context, int i) {
                              return Card(
                                clipBehavior: Clip.antiAlias,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Icon(Icons.person),
                                      title: Text(
                                          "${snapshot.data[i]["candidat_nom"]}"),
                                      subtitle: Text(
                                        "Code du candidat ${snapshot.data[i]["candidat_code"]}",
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6)),
                                      ),
                                    ),
                                    Image.memory(
                                      Base64Codec().decode(
                                          snapshot.data[i]["candidat_photo"]),
                                      fit: BoxFit.fill,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        "Email:${snapshot.data[i]["candidat_email"]}",
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        "Numéro de téléphone: ${snapshot.data[i]["candidat"]}",
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6)),
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
                                                          AjouterCandidat()));
                        
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
                                                          ModifierCandidat(
                                                              snapshot.data[i])));
                                            
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
                                                      (_) =>
                                                          CupertinoAlertDialog(
                                                            title: Text(
                                                                "Etes-vous sûr de vouloir supprimer ce candidat?"),
                                                            // content: Text(
                                                            //     "This is the content"),
                                                            actions: [
                                                              // Close the dialog
                                                              CupertinoButton(
                                                                child: Text(
                                                                    "OUI",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .orange[900])),
                                                                onPressed: () {
                                                                  
                                                                },
                                                              ),
                                                              CupertinoButton(
                                                                  child: Text(
                                                                      'NON',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.orange[900])),
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
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }

                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                    FutureBuilder(builder: null),
                    FutureBuilder(builder: null),
                    FutureBuilder(builder: null),
                  ])),
                ]))));
  }
}
