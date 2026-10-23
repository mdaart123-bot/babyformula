import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/catalog.dart';
import '../theme/app_colors.dart';
import '../widgets/app_card.dart';
import '../widgets/leaf_mark.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, this.onExplore, this.onRecycle});

  final VoidCallback? onExplore;
  final VoidCallback? onRecycle;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _HeroBlock(),
                const SizedBox(height: 22),
                Text(
                  'A calmer tin of milk',
                  style: GoogleFonts.lexendDeca(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Little Leaf is an infant formula made in small batches. '
                  'We keep the ingredient list short, skip palm oil, and '
                  'print only what a parent actually needs on the label.',
                  style: GoogleFonts.lexendDeca(
                    fontSize: 15,
                    height: 1.55,
                    color: AppColors.moss,
                  ),
                ),
                const SizedBox(height: 22),
                const _FactRow(),
                const SizedBox(height: 22),
                Text(
                  'Inside the tin',
                  style: GoogleFonts.lexendDeca(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                const _IngredientTile(
                  title: 'Organic lactose',
                  body: 'The primary carbohydrate, the same sugar found in breast milk.',
                ),
                const SizedBox(height: 10),
                const _IngredientTile(
                  title: 'Whey-dominant protein',
                  body: 'A 60:40 whey-to-casein ratio in Stage 1, with DHA and ARA.',
                ),
                const SizedBox(height: 10),
                const _IngredientTile(
                  title: 'Plant oils, no palm',
                  body: 'Sunflower, rapeseed, and coconut. Softer on digestion and on forests.',
                ),
                const SizedBox(height: 22),
                AppCard(
                  color: AppColors.cream,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Made to be used up',
                        style: GoogleFonts.lexendDeca(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'What we cannot put in a tin is listed on Recycle. '
                        'Whey, fibre, steel, and paper leave the plant through partners — never landfill first.',
                        style: GoogleFonts.lexendDeca(
                          fontSize: 13.5,
                          height: 1.5,
                          color: AppColors.forest.withValues(alpha: 0.8),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          _TextLink(label: 'See the shop', onTap: onExplore),
                          const SizedBox(width: 18),
                          _TextLink(label: 'See waste streams', onTap: onRecycle),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroBlock extends StatelessWidget {
  const _HeroBlock();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: AppColors.forest,
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LeafMark(size: 56),
          const SizedBox(height: 18),
          Text(
            Catalog.brand,
            style: GoogleFonts.lexendDeca(
              color: AppColors.cream,
              fontSize: 13,
              letterSpacing: 1.4,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Gentle nutrition\nfrom leaf to bottle.',
            style: GoogleFonts.lexendDeca(
              color: AppColors.white,
              fontSize: 28,
              height: 1.2,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Stage 1 to 3 · organic dairy · recyclable steel tins',
            style: GoogleFonts.lexendDeca(
              color: AppColors.cream.withValues(alpha: 0.9),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _FactRow extends StatelessWidget {
  const _FactRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: _FactChip(label: 'No palm oil')),
        SizedBox(width: 10),
        Expanded(child: _FactChip(label: 'DHA + ARA')),
        SizedBox(width: 10),
        Expanded(child: _FactChip(label: '800 g tins')),
      ],
    );
  }
}

class _FactChip extends StatelessWidget {
  const _FactChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppColors.softShadow,
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: GoogleFonts.lexendDeca(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.forest,
        ),
      ),
    );
  }
}

class _IngredientTile extends StatelessWidget {
  const _IngredientTile({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 6),
            decoration: const BoxDecoration(
              color: AppColors.moss,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.lexendDeca(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: GoogleFonts.lexendDeca(
                    fontSize: 13,
                    height: 1.45,
                    color: AppColors.moss,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TextLink extends StatelessWidget {
  const _TextLink({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: GoogleFonts.lexendDeca(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.forest,
        ),
      ),
    );
  }
}
