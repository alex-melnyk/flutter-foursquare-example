import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  final label;

  const EmptyScreen({Key key, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text(label),),
    );
  }
}
