import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../state/cart_controller.dart';
import '../theme/app_colors.dart';
import '../widgets/app_card.dart';
import '../widgets/primary_button.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _address.dispose();
    super.dispose();
  }

  Future<void> _checkout() async {
    final cart = CartScope.of(context);
    if (cart.lines.isEmpty) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final name = _name.text.trim();
    final total = cart.totalLabel;

    cart.clear();
    _name.clear();
    _phone.clear();
    _address.clear();

    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Order received', style: GoogleFonts.lexendDeca(fontWeight: FontWeight.w600)),
          content: Text(
            'Thank you, $name. We will confirm $total by phone and deliver to the address you entered.',
            style: GoogleFonts.lexendDeca(height: 1.45, fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Done', style: GoogleFonts.lexendDeca(color: AppColors.forest)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
      children: [
        Text(
          'Cart',
          style: GoogleFonts.lexendDeca(fontSize: 26, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        Text(
          cart.lines.isEmpty
              ? 'Your tin rack is empty.'
              : '${cart.itemCount} item${cart.itemCount == 1 ? '' : 's'} · ${cart.totalLabel}',
          style: GoogleFonts.lexendDeca(color: AppColors.moss, fontSize: 14),
        ),
        const SizedBox(height: 16),
        if (cart.lines.isEmpty)
          AppCard(
            color: AppColors.cream,
            child: Text(
              'Add formula from Explore, then return here to check out.',
              style: GoogleFonts.lexendDeca(height: 1.45),
            ),
          )
        else ...[
          ...cart.lines.map(
            (line) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppCard(
                padding: const EdgeInsets.fromLTRB(16, 14, 8, 14),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            line.product.name,
                            style: GoogleFonts.lexendDeca(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '${line.product.priceLabel} · ${line.product.weight}',
                            style: GoogleFonts.lexendDeca(fontSize: 12.5, color: AppColors.moss),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => cart.decrement(line.product.id),
                      icon: const Icon(Icons.remove_circle_outline, color: AppColors.moss),
                    ),
                    Text(
                      '${line.quantity}',
                      style: GoogleFonts.lexendDeca(fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                      onPressed: () => cart.add(line.product),
                      icon: const Icon(Icons.add_circle_outline, color: AppColors.forest),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AppCard(
            color: AppColors.forest,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: GoogleFonts.lexendDeca(color: AppColors.cream, fontSize: 15),
                ),
                Text(
                  cart.totalLabel,
                  style: GoogleFonts.lexendDeca(
                    color: AppColors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Text(
            'Checkout',
            style: GoogleFonts.lexendDeca(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            'Name, phone, and address are required to place the order.',
            style: GoogleFonts.lexendDeca(color: AppColors.moss, fontSize: 13.5, height: 1.4),
          ),
          const SizedBox(height: 14),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _name,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(labelText: 'Full name'),
                  validator: (value) {
                    if (value == null || value.trim().length < 2) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'Phone number'),
                  validator: (value) {
                    final digits = (value ?? '').replaceAll(RegExp(r'\D'), '');
                    if (digits.length < 8) {
                      return 'Enter a valid phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _address,
                  maxLines: 3,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(labelText: 'Delivery address'),
                  validator: (value) {
                    if (value == null || value.trim().length < 8) {
                      return 'Enter a full street address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),
                PrimaryButton(
                  label: 'Place order',
                  icon: Icons.lock_outline,
                  onPressed: _checkout,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
