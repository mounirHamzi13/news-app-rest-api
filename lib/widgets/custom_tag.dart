import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// ignore: must_be_immutable
class CustomTag extends StatelessWidget {
  final Color background;
  final List<Widget> children;
  double padding;
  double radius;
  double? width;
  CustomTag(
      {super.key,
      required this.background,
      required this.children,
      this.padding = 20,
      this.radius = 30,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          color: background, borderRadius: BorderRadius.circular(radius)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}
