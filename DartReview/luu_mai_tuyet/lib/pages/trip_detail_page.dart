// lib/screens/trip_detail_page.dart
import 'package:flutter/material.dart';
import '../models/travel.dart';

class TripDetailPage extends StatelessWidget {
  final Trip trip;

  const TripDetailPage({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(trip.name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(trip.imagePath, fit: BoxFit.cover, width: 300, height: 200),
            const SizedBox(height: 20),
            Text(trip.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
