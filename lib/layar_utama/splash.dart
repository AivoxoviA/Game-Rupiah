import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../index.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var _visible = false;

  void setVisible() {
    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setVisible();
  }

  @override
  Widget build(BuildContext context) {
    var indexState = context.watch<IndexState>();
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 2000),
          opacity: _visible ? 1.0 : 0.0,
          child: SizedBox(
            width: 256,
            height: 256,
            child: Image.asset('assets/images/logo.png'),
          ),
          onEnd: () {
            indexState.upState();
          },
        ),
      ),
    );
  }
}
