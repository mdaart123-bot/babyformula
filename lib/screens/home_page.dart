import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/catalog.dart';
import '../theme/app_colors.dart';
import '../widgets/app_card.dart';
import '../widgets/leaf_mark.dart';
import '../widgets/photo_frame.dart';

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
                  'Une première céréale, tout en douceur',
                  style: GoogleFonts.lexendDeca(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Little Leaf est un aliment de complément pour la diversification, '
                  'à base de céréales, de légumineuses et de légumes. '
                  'Les ingrédients sont locaux, la liste est courte, '
                  'et la lyophilisation préserve ce qui compte pour bébé.',
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
                  'Dans le sachet',
                  style: GoogleFonts.lexendDeca(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                const _IngredientTile(
                  title: 'Riz et avoine',
                  body: 'Des céréales douces et faciles à digérer, sources d\'énergie et de fibres.',
                ),
                const SizedBox(height: 10),
                const _IngredientTile(
                  title: 'Lentilles',
                  body: 'Riches en lysine, fer, zinc et folates. Associées aux céréales, '
                      'elles complètent leurs protéines.',
                ),
                const SizedBox(height: 10),
                const _IngredientTile(
                  title: 'Légumes et fruits',
                  body: 'Carotte, betterave, courgette et pomme, pour varier les saveurs '
                      'dès les premières cuillères.',
                ),
                const SizedBox(height: 22),
                AppCard(
                  color: AppColors.cream,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pensée pour préserver',
                        style: GoogleFonts.lexendDeca(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Trempage des légumineuses, cuisson vapeur, puis lyophilisation : '
                        'une texture lisse et peu épaisse, des nutriments mieux conservés '
                        'et une longue conservation.',
                        style: GoogleFonts.lexendDeca(
                          fontSize: 13.5,
                          height: 1.5,
                          color: AppColors.forest.withValues(alpha: 0.8),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          _TextLink(label: 'Voir la boutique', onTap: onExplore),
                          const SizedBox(width: 18),
                          _TextLink(label: 'Voir le recyclage', onTap: onRecycle),
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
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              const PhotoFrame(
                asset: Catalog.homeImage,
                height: 210,
                borderRadius: BorderRadius.zero,
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.forest.withValues(alpha: 0.15),
                        AppColors.forest.withValues(alpha: 0.72),
                      ],
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 18,
                top: 18,
                child: LeafMark(size: 48),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 20, 22, 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  'Une nutrition douce,\nde la graine à la cuillère.',
                  style: GoogleFonts.lexendDeca(
                    color: AppColors.white,
                    fontSize: 28,
                    height: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Dès 6 mois · céréales et légumineuses · lyophilisé',
                  style: GoogleFonts.lexendDeca(
                    color: AppColors.cream.withValues(alpha: 0.9),
                    fontSize: 13,
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

class _FactRow extends StatelessWidget {
  const _FactRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: _FactChip(label: 'Lyophilisé')),
        SizedBox(width: 10),
        Expanded(child: _FactChip(label: 'Dès 6 mois')),
        SizedBox(width: 10),
        Expanded(child: _FactChip(label: 'Sans lait')),
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