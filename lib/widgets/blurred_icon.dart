import 'dart:ui';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BlurredIcon extends StatelessWidget {
  Widget widget;
  double height;
  double width; 
  BlurredIcon({
    super.key,
    required this.widget,
    this.height = 60 , 
    this.width = 60 ,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 90),
            child: Container(
              width: width,
              height: height,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: Center(child: widget),
            ),
          ),
        ),
        // ),
      ],
    );
  }
}
