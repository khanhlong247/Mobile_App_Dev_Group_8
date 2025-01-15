import 'package:flutter/material.dart';

class TravelDiaryLayoutDelegate extends MultiChildLayoutDelegate {
  TravelDiaryLayoutDelegate({required this.textDirection});

  final TextDirection textDirection;

  @override
  void performLayout(Size size) {
    const double headerHeightFactor = 0.4;
    final double headerHeight = size.height * headerHeightFactor;
    final double listHeight = size.height - headerHeight;

    if (hasChild('header')) {
      layoutChild(
        'header',
        BoxConstraints.tightFor(width: size.width, height: headerHeight),
      );
      positionChild('header', Offset.zero);
    }

    if (hasChild('list')) {
      layoutChild(
        'list',
        BoxConstraints.tightFor(width: size.width, height: listHeight),
      );
      positionChild('list', Offset(0, headerHeight));
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) => true;
}
