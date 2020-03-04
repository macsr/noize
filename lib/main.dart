import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noize/screens/main_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFF2F364B)
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      Duration(seconds: 1),
        (){
          Navigator.of(context).pop();
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => MainScreen()
        ));
        }
    );
//    Timer(Duration(seconds: 3),()=> print("App Start"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit:StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Color(0xFF272A33)),
          ),
          Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 80.0,
                        child: Image(
                          image: AssetImage("images/noize_logo.jpg"),
                          height: 110.0,
                          width: 110.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0,bottom: 30.0),
                      ),
                      Text(
                        "Noize App",style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                      ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                    ),
                    Text("Sri Lanka's Number 1 News Portal",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0
                    ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
