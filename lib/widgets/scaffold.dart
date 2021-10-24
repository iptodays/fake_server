import 'package:flutter/material.dart';

class CustomScaffold extends StatefulWidget {
  const CustomScaffold({
    Key? key,
    required this.body,
    this.appBar,
  }) : super(key: key);

  final Widget body;

  final AppBar? appBar;

  @override
  State<StatefulWidget> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: widget.body,
    );
  }
}
