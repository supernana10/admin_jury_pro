import 'package:admin_jury_pro/pages/ajouterEvenement.dart';
import 'package:admin_jury_pro/pages/evenements.dart';
import 'package:admin_jury_pro/pages/modifierEvenement.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(OngletAdmin());

class OngletAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Example(),
    );
  }
}

class Example extends StatefulWidget {
  Example({Key key}) : super(key: key);

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  List data;
  List evenements;

  String get uri => null;

  Future getData() async {
    var response = await http.get("http://172.31.239.223:8000/evenements");
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

  Future deleteEvenements(uri) async {
    String _uri = uri;

    var request = http.Request('POST',
        Uri.parse('http://172.31.239.223:8000/evenements/delete/' + _uri));
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
          length: 2,
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
                    icon: Icon(Icons.event),
                    text: "event",
                  ),
                  Tab(
                    icon: Icon(Icons.pageview),
                    text: "pageview",
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
                                leading: Icon(Icons.arrow_drop_down_circle),
                                title: Text("${data[i]["evenement_nom"]}"),
                                subtitle: Text(
                                  "Evenement de ${data[i]["evenement_type"]}",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                              ),
                              Image.network("https://picsum.photos/250?image=9",
                                  fit: BoxFit.fill, loadingBuilder:
                                      (BuildContext context, Widget child,
                                          ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes
                                        : null,
                                  ),
                                );
                              }),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "Du: ${data[i]["evenement_date_debut"]} Au ${data[i]["evenement_date_fin"]}",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "Nombre de participants: ${data[i]["participant"]}",
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
                                                        this.deleteEvenements(
                                                            "${data[i]["evenement_id"]}"
                                                                .toString());
                                                        print(
                                                            "${data[i]["evenement_id"]}"
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
                    Center(
                      child: Icon(Icons.pageview),
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
