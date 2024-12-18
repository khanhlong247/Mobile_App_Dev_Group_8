import 'package:flutter/material.dart';

void main() => runApp(const TravelDiaryApp());

class TravelDiaryApp extends StatelessWidget {
  const TravelDiaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Nhật ký Du lịch'),
          ),
          body: const CustomMultiChildLayoutExample(),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
              BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
            ],
          ),
        ),
      ),
    );
  }
}

class _TravelDiaryLayoutDelegate extends MultiChildLayoutDelegate {
  _TravelDiaryLayoutDelegate({
    required this.textDirection,
  });

  final TextDirection textDirection;

  @override
  void performLayout(Size size) {
    // Kích thước từng phần
    const double headerHeight = 150.0; // Phần ảnh hoặc GPS
    const double listHeight = 300.0; // Danh sách nhật ký

    // Layout phần đầu (ảnh + GPS)
    if (hasChild('header')) {
      layoutChild(
        'header',
        BoxConstraints.tightFor(width: size.width, height: headerHeight),
      );
      positionChild('header', Offset.zero);
    }

    // Layout phần danh sách
    if (hasChild('list')) {
      layoutChild(
        'list',
        BoxConstraints.tightFor(width: size.width, height: listHeight),
      );
      positionChild('list', Offset(0, headerHeight));
    }

    // Layout phần footer (button hoặc các công cụ)
    if (hasChild('footer')) {
      final double footerHeight = size.height - headerHeight - listHeight;
      layoutChild(
        'footer',
        BoxConstraints.tightFor(width: size.width, height: footerHeight),
      );
      positionChild('footer', Offset(0, headerHeight + listHeight));
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return true;
  }
}

class CustomMultiChildLayoutExample extends StatelessWidget {
  const CustomMultiChildLayoutExample({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      delegate: _TravelDiaryLayoutDelegate(
        textDirection: Directionality.of(context),
      ),
      children: <Widget>[
        // Phần đầu: Ảnh hoặc GPS
        LayoutId(
          id: 'header',
          child: Container(
            color: Colors.blueAccent,
            alignment: Alignment.center,
            child: const Text(
              'Ảnh hoặc GPS',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
        // Phần danh sách nhật ký
        LayoutId(
          id: 'list',
          child: Container(
            color: Colors.grey[300],
            alignment: Alignment.topCenter,
            child: const Text(
              'Danh sách nhật ký',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        // Phần footer: Nút hoặc công cụ
        LayoutId(
          id: 'footer',
          child: Container(
            color: Colors.green,
            alignment: Alignment.center,
            child: const Text(
              'Công cụ',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
