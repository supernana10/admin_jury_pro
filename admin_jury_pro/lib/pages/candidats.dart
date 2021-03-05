import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'dart:developer' as developer;
//import 'package:JuryPro/detailsCandidat.dart';
//import 'package:JuryPro/ajouterCandidat.dart';
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: Candidats(),
  ));
}

class Candidats extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Candidats> {
  List candidat;
  List evenements;

  Future getCandidat() async {
    http.Response response =
        await http.get("http://172.31.239.223:8000/candidats");
    candidat = json.decode(response.body);
    // print("Response : ");
    // print(candidat);
    setState(() {
      candidat = candidat;
    });
  }

  @override
  void initState() {
    super.initState();
    getCandidat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Candidats"),
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: candidat == null ? 0 : candidat.length,
        itemBuilder: (BuildContext context, int index) {
          Uint8List bytes;
          if (candidat[index]["candidat_photo"] != null) {
            bytes = base64Decode(candidat[index]["candidat_photo"]);
          }

          return Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                bytes != null
                    ? Image.memory(bytes)
                    : Image.network(
                        "http://assets.stickpng.com/images/585e4bc4cb11b227491c3395.png",
                        fit: BoxFit.fill,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },
                        height: 120,
                        width: 140,
                      ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "${candidat[index]["candidat_nom"]} ${candidat[index]["candidat_prenom"]}",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.9),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                /* ButtonBar(alignment: MainAxisAlignment.center, children: [
                  FlatButton(
                    textColor: Colors.blueAccent,
                    color: Colors.orange,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => DetailCandidat(
                                  "${candidat[index]["candidat_id"]}")));
                    },
                    child: const Text(
                      'Details',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ]), */
              ],
            ),
          );
        },
      ),
      /* floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => AjouterCandidat()));
        },
        child: Icon(Icons.add),
      ), */
    );
  }
}
