import 'package:flutter/material.dart';

import '../models/product.dart';
import '../models/waste_item.dart';

class Catalog {
  static const email = 'hello@littleleaf.com';
  static const phone = '+1 (800) 555-0148';
  static const brand = 'Little Leaf';
  static const homeImage = 'assets/images/home_hero.jpg';

  static const products = <Product>[
    Product(
      id: 's1',
      name: 'First Milk',
      subtitle: 'Stage 1 · 0–6 months',
      description:
          'A gentle starter formula with organic lactose, DHA, and a whey-dominant protein ratio close to breast milk.',
      price: 28.50,
      weight: '800 g',
      stage: ProductStage.stage1,
      icon: Icons.spa_outlined,
      imageAsset: 'assets/images/product_s1.jpg',
    ),
    Product(
      id: 's1n',
      name: 'Night Feed',
      subtitle: 'Stage 1 · evening blend',
      description:
          'The same Stage 1 base with a slightly creamier mouthfeel, made for calmer late feeds.',
      price: 29.00,
      weight: '800 g',
      stage: ProductStage.stage1,
      icon: Icons.nights_stay_outlined,
      imageAsset: 'assets/images/product_s1n.jpg',
    ),
    Product(
      id: 's2',
      name: 'Follow-On',
      subtitle: 'Stage 2 · 6–12 months',
      description:
          'Iron-forward follow-on milk with GOS fibres and plant-sourced DHA for the weaning months.',
      price: 27.00,
      weight: '800 g',
      stage: ProductStage.stage2,
      icon: Icons.eco_outlined,
      imageAsset: 'assets/images/product_s2.jpg',
    ),
    Product(
      id: 's3',
      name: 'Growing Up',
      subtitle: 'Stage 3 · 12–36 months',
      description:
          'A toddler milk with calcium, vitamin D, and a lighter sweetness. Designed to sit beside family meals.',
      price: 26.00,
      weight: '800 g',
      stage: ProductStage.stage3,
      icon: Icons.park_outlined,
      imageAsset: 'assets/images/product_s3.jpg',
    ),
    Product(
      id: 'gentle',
      name: 'Gentle Comfort',
      subtitle: 'Partially hydrolysed',
      description:
          'For sensitive tummies. Proteins are broken down, with reduced lactose and no palm oil.',
      price: 32.00,
      weight: '800 g',
      stage: ProductStage.specialty,
      icon: Icons.favorite_border,
      imageAsset: 'assets/images/product_gentle.jpg',
    ),
    Product(
      id: 'goat',
      name: 'Goat Milk',
      subtitle: 'A2-style goat protein',
      description:
          'Whole goat milk formula with naturally smaller fat globules. Stage 2 equivalent.',
      price: 34.50,
      weight: '800 g',
      stage: ProductStage.specialty,
      icon: Icons.agriculture_outlined,
      imageAsset: 'assets/images/product_goat.jpg',
    ),
    Product(
      id: 'rtf',
      name: 'Ready to Feed',
      subtitle: '8 sterile bottles',
      description:
          'Liquid Stage 1 in 70 ml bottles. No scoop, no kettle — for travel and the first weeks home.',
      price: 18.00,
      weight: '8 × 70 ml',
      stage: ProductStage.stage1,
      icon: Icons.water_drop_outlined,
      imageAsset: 'assets/images/product_rtf.jpg',
    ),
    Product(
      id: 'cereal',
      name: 'Oat Cereal',
      subtitle: 'From 6 months',
      description:
          'Fine organic oat cereal meant to mix with First Milk or Follow-On. One ingredient besides a pinch of vanilla.',
      price: 12.00,
      weight: '250 g',
      stage: ProductStage.stage2,
      icon: Icons.grain_outlined,
      imageAsset: 'assets/images/product_cereal.jpg',
    ),
  ];

  static const waste = <WasteItem>[
    WasteItem(
      id: 'whey',
      title: 'Food-grade whey solids',
      category: 'Protein',
      summary:
          'Surplus whey remaining after standardisation. Suitable for animal feed blenders or further food processing.',
      volume: '2–4 t / week',
      icon: Icons.science_outlined,
      imageAsset: 'assets/images/waste_whey.jpg',
    ),
    WasteItem(
      id: 'lactose',
      title: 'Lactose crystal surplus',
      category: 'Carbohydrate',
      summary:
          'Off-cut lactose crystals from drying. Food-adjacent, not packed for infant use.',
      volume: '800 kg / week',
      icon: Icons.bubble_chart_outlined,
      imageAsset: 'assets/images/waste_lactose.jpg',
    ),
    WasteItem(
      id: 'fiber',
      title: 'Plant fibre from filtration',
      category: 'Organic',
      summary:
          'Pressed fibre from oil and DHA filtration. Useful as compost feedstock or biogas.',
      volume: '1.2 t / week',
      icon: Icons.grass,
      imageAsset: 'assets/images/waste_fiber.jpg',
    ),
    WasteItem(
      id: 'offspec',
      title: 'Off-spec powder',
      category: 'Nutrition',
      summary:
          'Batches that miss retail spec (colour or moisture) but remain safe for non-infant food use.',
      volume: 'variable',
      icon: Icons.inventory_2_outlined,
      imageAsset: 'assets/images/waste_offspec.jpg',
    ),
    WasteItem(
      id: 'steel',
      title: 'Steel tin offcuts',
      category: 'Metal',
      summary:
          'Clean steel leftover from can forming. Recyclers and small fabricators welcome.',
      volume: '300 kg / week',
      icon: Icons.hardware_outlined,
      imageAsset: 'assets/images/waste_steel.jpg',
    ),
    WasteItem(
      id: 'kraft',
      title: 'Unprinted kraft paper',
      category: 'Fibre',
      summary:
          'Outer wrap trimmings, unprinted. Good for pulp or packing fill.',
      volume: '150 kg / week',
      icon: Icons.description_outlined,
      imageAsset: 'assets/images/waste_kraft.jpg',
    ),
    WasteItem(
      id: 'oil',
      title: 'Spent vegetable oil',
      category: 'Oil',
      summary:
          'Used blending oil from the lipid line. Suitable for biodiesel partners.',
      volume: '400 L / week',
      icon: Icons.opacity_outlined,
      imageAsset: 'assets/images/waste_oil.jpg',
    ),
  ];
}
