import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:noize/screens/news_screen.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:webview_flutter/webview_flutter.dart';

final Color  backgroundColor = Color(0xFF272A33);

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin{
  bool isCollapsed = true;
  double screenWidth,screenHeight,_left,_right;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;
  Container _container ;
  final Completer<WebViewController> _webViewController = Completer<WebViewController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this,duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1,0), end: Offset(0, 0)).animate(_controller);
    _container (Container) async => NewsScreen(selectedUrl: "http://noizetv.lk");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    _left = 0;
    _right = 0;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          menu(context),
          mainScreen(context),
          SwipeDetector(
            onSwipeLeft: (){
              setState(() {
                if(isCollapsed){
//                  _controller.forward();
                }else{
                  _controller.reverse();
                  isCollapsed = true;
                }

              });
            },
            onSwipeRight: (){
              setState(() {
                if(isCollapsed){
                  _controller.forward();
                  isCollapsed = false;
                }else{
//                  _controller.reverse();
                }

              });
            },
          )
        ],
      ),

    );
  }

  Widget menu(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0),
          child: Align(
            alignment: Alignment.centerLeft,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 40.0,
                              child: Image(
                                image: AssetImage("images/noize_logo.jpg"),
                                height: 50.0,
                                width: 50.0,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text("Noize App", style: TextStyle(fontFamily:'RobotoMono', color: Colors.white70,fontSize: 20,fontWeight: FontWeight.bold),)
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(top:85.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  FlatButton(
                                    child: Text("Home", style: TextStyle(color: Colors.white,fontSize: 18),),
                                    onPressed: (){
                                      setState(() {
                                        print("Button Clicked");
                                      });
                                    },
                                  ),
                                ],

                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  FlatButton(
                                    child: Text("News Feed", style: TextStyle(color: Colors.white,fontSize: 18),),
                                    onPressed: (){
                                      setState(() {
                                        print("Button Clicked");
                                      });
                                    },
                                  ),
//                                  SizedBox(height: 15,)
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  FlatButton(
                                  child: Text("Videos", style: TextStyle(color: Colors.white,fontSize: 18),),
                                  onPressed: (){
                                    setState(() {
                                      print("Button Clicked");
                                    });
                                  },
                                ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  FlatButton(
                                    child: Text("About", style: TextStyle(color: Colors.white,fontSize: 18),),
                                    onPressed: (){
                                      setState(() {
                                        print("Button Clicked");
                                      });
                                    },
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )

                ],
              )
          ),
        ),
      ),
    );
  }
  Widget mainScreen(BuildContext context){
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
//      child: GestureDetector(
//        onHorizontalDragEnd: (MainScreen){
//          setState(() {
//            if(isCollapsed){
//              _controller.forward();
//            }else{
//              _controller.reverse();
//            }
//            isCollapsed = !isCollapsed;
//          });
//        },
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Material(
            animationDuration: duration,
            elevation: 8,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: backgroundColor,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          InkWell(
                            child: Icon(
                              Icons.menu, color: Colors.white,
                            ),
                            onTap: (){
//                          print(isCollapsed);
                              setState(() {
                                if(isCollapsed){
                                  _controller.forward();
                                }else{
                                  _controller.reverse();
                                }
                                isCollapsed =!isCollapsed;
                              });
                            },
                          ),
                          Text("Noize App" , style: TextStyle(fontSize: 22,color: Colors.white),),
//                  Icon(Icons.settings,color: Colors.white,)
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 20,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(left: 15,bottom: 15,top: 20),
                            child: WebView(
                              initialUrl:"http://noizetv.lk",
                              javascriptMode: JavascriptMode.unrestricted,
                              onWebViewCreated:(WebViewController webViewController){
                                _webViewController.complete(webViewController);
                              },
                              gestureRecognizers: Set()
                                ..add(Factory<HorizontalDragGestureRecognizer>(
                                        () => HorizontalDragGestureRecognizer())),
                            ),
                          )
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
        ),
//      ),
    );
  }
}
