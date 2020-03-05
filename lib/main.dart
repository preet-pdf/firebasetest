import 'package:flutter/material.dart';
//import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
    backgroundColorStart: Colors.black87,
    backgroundColorEnd: Colors.blue,
        title: Center(
            child: Text(
          'News of Charusat',
        )),
      ),
      
      body: Center(
        child: Container(
          decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.black87, Colors.blue],begin: Alignment.topRight,
              end: Alignment.bottomLeft,)),
            padding: const EdgeInsets.all(10.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('posts').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    return new ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        return new CustomCard(
                          title: document['title'],
                        );
                      }).toList(),
                    );
                }
              },
            )),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  CustomCard({@required this.title});

  final title;

  @override
  Widget build(BuildContext context) {
    Text txt = Text(title);
    var value = txt.data;

    return Center(
        child: Container(
      child: RotateAnimatedTextKit(
          onTap: () {
            print("Tap Event");
          },
          duration: Duration(milliseconds: 10000),
          pause: Duration(microseconds: 200000),
          text: [value],
          textStyle: TextStyle(
              fontSize: 20.0,
              fontFamily: "Horizon",
              color: Colors.cyanAccent),
          textAlign: TextAlign.start,
          isRepeatingAnimation: true,
          totalRepeatCount: 1000,
          alignment: AlignmentDirectional.topStart // or Alignment.topLeft
          ),
    ));
  }
}
