import 'package:flutter/material.dart';

class Index extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Index();
}

class _Index extends State<Index> {
  var _visible = false;

  @override
  void initState() {
    super.initState();
    setVisible();
  }

  void setVisible() {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 1000),
          opacity: _visible ? 1.0 : 0.0,
          child: Container(
            width: 256,
            height: 256,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
