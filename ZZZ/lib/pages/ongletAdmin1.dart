import 'package:admin_jury_pro/pages/evenements.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';

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
                    Center(
                      child: Text("jhgjhgjhg"),
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
