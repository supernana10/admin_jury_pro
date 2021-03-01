
import 'package:admin_jury_pro/pages/old.dart/accueil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_splash/flutter_splash.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(new MaterialApp(
    home: new Splash(),
  ));
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 7,
      navigateAfterSeconds: new Accueil(),
      title: new Text(
        'BIENVENUE A VOUS',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
      ),
      image: new Image.network(
        'https://cdn.pixabay.com/photo/2021/01/18/12/45/coffee-beans-5928036_1280.jpg',
      ),
      backgroundColor: Colors.orange[50],
      loaderColor: Colors.deepOrange,
    );
  }
}
