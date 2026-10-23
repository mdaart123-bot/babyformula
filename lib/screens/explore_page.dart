import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/catalog.dart';
import '../models/product.dart';
import '../state/cart_controller.dart';
import '../theme/app_colors.dart';
import '../widgets/app_card.dart';
import '../widgets/primary_button.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final _search = TextEditingController();
  ProductStage _stage = ProductStage.all;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  List<Product> get _visible {
    final query = _search.text.trim().toLowerCase();
    return Catalog.products.where((product) {
      final stageOk = _stage == ProductStage.all || product.stage == _stage;
      if (!stageOk) return false;
      if (query.isEmpty) return true;
      return product.name.toLowerCase().contains(query) ||
          product.subtitle.toLowerCase().contains(query) ||
          product.description.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final products = _visible;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
      children: [
        Text(
          'The cupboard',
          style: GoogleFonts.lexendDeca(
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Search the range, then add tins to your cart.',
          style: GoogleFonts.lexendDeca(color: AppColors.moss, fontSize: 14),
        ),
        const SizedBox(height: 16),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: AppColors.softShadow,
            color: AppColors.white,
          ),
          child: TextField(
            controller: _search,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Search formula, stage, cereal…',
              prefixIcon: const Icon(Icons.search, color: AppColors.moss),
              suffixIcon: _search.text.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () {
                        _search.clear();
                        setState(() {});
                      },
                      icon: const Icon(Icons.close, color: AppColors.moss),
                    ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 14),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _FilterChip(
                label: 'All',
                selected: _stage == ProductStage.all,
                onTap: () => setState(() => _stage = ProductStage.all),
              ),
              _FilterChip(
                label: 'Stage 1',
                selected: _stage == ProductStage.stage1,
                onTap: () => setState(() => _stage = ProductStage.stage1),
              ),
              _FilterChip(
                label: 'Stage 2',
                selected: _stage == ProductStage.stage2,
                onTap: () => setState(() => _stage = ProductStage.stage2),
              ),
              _FilterChip(
                label: 'Stage 3',
                selected: _stage == ProductStage.stage3,
                onTap: () => setState(() => _stage = ProductStage.stage3),
              ),
              _FilterChip(
                label: 'Specialty',
                selected: _stage == ProductStage.specialty,
                onTap: () => setState(() => _stage = ProductStage.specialty),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        if (products.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text(
              'Nothing matches that search.',
              textAlign: TextAlign.center,
              style: GoogleFonts.lexendDeca(color: AppColors.moss),
            ),
          )
        else
          ...products.map(
            (product) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _ProductCard(product: product),
            ),
          ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: selected ? AppColors.forest : AppColors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: AppColors.softShadow,
          ),
          child: Text(
            label,
            style: GoogleFonts.lexendDeca(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: selected ? AppColors.white : AppColors.forest,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.cream,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(product.icon, color: AppColors.forest),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: GoogleFonts.lexendDeca(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${product.subtitle} · ${product.weight}',
                      style: GoogleFonts.lexendDeca(
                        fontSize: 12.5,
                        color: AppColors.moss,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                product.priceLabel,
                style: GoogleFonts.lexendDeca(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            product.description,
            style: GoogleFonts.lexendDeca(
              fontSize: 13,
              height: 1.45,
              color: AppColors.forest.withValues(alpha: 0.75),
            ),
          ),
          const SizedBox(height: 14),
          PrimaryButton(
            label: 'Add to cart',
            icon: Icons.add_shopping_cart_outlined,
            onPressed: () {
              cart.add(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${product.name} added'),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: AppColors.forest,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
