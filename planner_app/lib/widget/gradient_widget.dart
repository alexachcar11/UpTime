import 'dart:html';

import 'package:flutter/material.dart';

class GradientWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          // title: Text(MyApp.title),
          centerTitle: true,
        ),
        body: Center(child: FlutterLogo(size: 200)),
      );
}
