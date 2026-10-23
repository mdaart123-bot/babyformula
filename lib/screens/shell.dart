import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/catalog.dart';
import '../state/cart_controller.dart';
import '../theme/app_colors.dart';
import '../widgets/leaf_mark.dart';
import 'cart_page.dart';
import 'contact_page.dart';
import 'explore_page.dart';
import 'home_page.dart';
import 'recycle_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);
    final titles = ['Home', 'Explore', 'Cart', 'Recycle', 'Contact'];

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        title: Row(
          children: [
            const LeafMark(size: 36),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Catalog.brand,
                  style: GoogleFonts.lexendDeca(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.forest,
                  ),
                ),
                Text(
                  titles[_index],
                  style: GoogleFonts.lexendDeca(
                    fontSize: 12,
                    color: AppColors.moss,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _index,
        children: [
          HomePage(
            onExplore: () => setState(() => _index = 1),
            onRecycle: () => setState(() => _index = 3),
          ),
          const ExplorePage(),
          const CartPage(),
          const RecyclePage(),
          const ContactPage(),
        ],
      ),
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: AppColors.navShadow,
        ),
        child: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (value) => setState(() => _index = value),
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            const NavigationDestination(
              icon: Icon(Icons.storefront_outlined),
              selectedIcon: Icon(Icons.storefront),
              label: 'Explore',
            ),
            NavigationDestination(
              icon: _CartIcon(count: cart.itemCount, filled: false),
              selectedIcon: _CartIcon(count: cart.itemCount, filled: true),
              label: 'Cart',
            ),
            const NavigationDestination(
              icon: Icon(Icons.recycling_outlined),
              selectedIcon: Icon(Icons.recycling),
              label: 'Recycle',
            ),
            const NavigationDestination(
              icon: Icon(Icons.mail_outline),
              selectedIcon: Icon(Icons.mail),
              label: 'Contact',
            ),
          ],
        ),
      ),
    );
  }
}

class _CartIcon extends StatelessWidget {
  const _CartIcon({required this.count, required this.filled});

  final int count;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Badge(
      isLabelVisible: count > 0,
      backgroundColor: AppColors.forest,
      label: Text(
        '$count',
        style: GoogleFonts.lexendDeca(fontSize: 10, color: AppColors.white),
      ),
      child: Icon(filled ? Icons.shopping_bag : Icons.shopping_bag_outlined),
    );
  }
}
