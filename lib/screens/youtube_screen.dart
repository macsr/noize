import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YouTubeScreen extends StatelessWidget {
  final String selectedUrl;
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  YouTubeScreen({
    @required this.selectedUrl,
  });


  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

