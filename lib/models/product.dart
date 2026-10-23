import 'package:flutter/material.dart';

enum ProductStage { all, stage1, stage2, stage3, specialty }

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.description,
    required this.price,
    required this.weight,
    required this.stage,
    required this.icon,
  });

  final String id;
  final String name;
  final String subtitle;
  final String description;
  final double price;
  final String weight;
  final ProductStage stage;
  final IconData icon;

  String get priceLabel => '\$${price.toStringAsFixed(2)}';
}
