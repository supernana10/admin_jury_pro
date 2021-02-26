import 'package:admin_jury_pro/pages/ajouterEvenement.dart';
import 'package:admin_jury_pro/pages/candidats.dart';
import 'package:admin_jury_pro/pages/evenements.dart';
import 'package:admin_jury_pro/pages/modifierEvenement.dart';
import 'package:admin_jury_pro/pages/ongletAdmin1.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(OngletAdmin1());

class OngletAdmin1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Example1(),
    );
  }
}

class Example1 extends StatefulWidget {
  Example1({Key key}) : super(key: key);

  @override
  _Example1State createState() => _Example1State();
}

class _Example1State extends State<Example1> {
  List data;
  List evenements;

  String get uri => null;

  Future getData() async {
    var response = await http.get("http://172.31.239.223:8000/candidats");
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
                backgroundColor: Colors.deepOrangeAccent,
                unselectedBackgroundColor: Colors.black,
                unselectedLabelStyle: TextStyle(color: Colors.white),
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                tabs: [
                  /*  GestureDetector(
                    child: Tab(icon: Icon(Icons.event)),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Evenement()));
                    },
                  ), */
                  Tab(
                    icon: Icon(Icons.person),
                    text: "candidat",
                  ),
                  Tab(
                    icon: Icon(Icons.how_to_vote),
                    text: "jury",
                  ),
                  Tab(
                    icon: Icon(Icons.people),
                    text: "groupes",
                  ),
                  Tab(
                    icon: Icon(Icons.mark_as_unread),
                    text: "critères",
                  ),
                  /* Tab(icon: Icon(Icons.directions_bike)),
                                Tab(icon: Icon(Icons.directions_car)),
                  Tab(icon: Icon(Icons.directions_transit)),
                  Tab(icon: Icon(Icons.directions_bike)), */
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    ListView.builder(
                      padding: EdgeInsets.all(20),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int i) {
                        return Card(
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(Icons.event_available),
                                title: Text("${data[i]["candidat_nom"]}"),
                                subtitle: Text(
                                  "Code du ${data[i]["candidat_code"]}",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                              ),
                              Image.memory(
                                Base64Codec().decode(data[i]["candidat_photo"]),
                                fit: BoxFit.fill,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "Email:${data[i]["candidat_email"]}",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "Numéro de téléphone: ${data[i]["candidat"]}",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                              ),
                              ButtonBar(
                                  alignment: MainAxisAlignment.end,
                                  children: [
                                    /* FlatButton(
                                      textColor: Colors.black,
                                      color: Colors.grey,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        OngletAdmin1()));
                                        getData();
                                      },
                                      child: const Text('VOIR'),
                                    ), */
                                    FlatButton(
                                      textColor: Colors.black,
                                      color: Colors.orange[800],
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        AjouterEvenement()));
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
                                                        ModifierEvenement(
                                                            data[i])));
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
                                                      "Etes-vous sûr de vouloir supprimer cet evenement?"),
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
                                                            "${data[i]["candidat_id"]}"
                                                                .toString());
                                                        print(
                                                            "${data[i]["candidat_id"]}"
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
