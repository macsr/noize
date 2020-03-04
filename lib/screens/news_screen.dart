import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsScreen extends StatelessWidget {
  final String selectedUrl;
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  NewsScreen({
    @required this.selectedUrl,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            child: WebView(
                initialUrl:selectedUrl,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated:(WebViewController webViewController){
                  _controller.complete(webViewController);
                },
              gestureRecognizers: Set()
                ..add(Factory<HorizontalDragGestureRecognizer>(
                        () => HorizontalDragGestureRecognizer())),
            ),
          )
        ],
      ),
    );
  }
}

