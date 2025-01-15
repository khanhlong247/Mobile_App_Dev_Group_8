import 'package:flutter/material.dart';
import '../widgets/gps_header.dart';
import '../widgets/travel_diary_layout_delegate.dart';

class CustomMultiChildLayoutExample extends StatelessWidget {
  const CustomMultiChildLayoutExample({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      delegate: TravelDiaryLayoutDelegate(
        textDirection: Directionality.of(context),
      ),
      children: <Widget>[
        LayoutId(id: 'header', child: const GPSHeader()),
        LayoutId(
          id: 'list',
          child: Container(
            color: Colors.grey[300],
            alignment: Alignment.topCenter,
            child: const Text(
              'Danh sách ảnh',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
