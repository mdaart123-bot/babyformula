import 'package:flutter/material.dart';

class WasteItem {
  const WasteItem({
    required this.id,
    required this.title,
    required this.category,
    required this.summary,
    required this.volume,
    required this.icon,
  });

  final String id;
  final String title;
  final String category;
  final String summary;
  final String volume;
  final IconData icon;
}
