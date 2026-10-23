import 'package:flutter/material.dart';

import '../models/cart_line.dart';
import '../models/product.dart';

class CartController extends ChangeNotifier {
  final List<CartLine> _lines = [];

  List<CartLine> get lines => List.unmodifiable(_lines);

  int get itemCount => _lines.fold(0, (sum, line) => sum + line.quantity);

  double get total => _lines.fold(0, (sum, line) => sum + line.subtotal);

  String get totalLabel => '\$${total.toStringAsFixed(2)}';

  void add(Product product) {
    final index = _lines.indexWhere((line) => line.product.id == product.id);
    if (index == -1) {
      _lines.add(CartLine(product: product, quantity: 1));
    } else {
      _lines[index] = _lines[index].copyWith(quantity: _lines[index].quantity + 1);
    }
    notifyListeners();
  }

  void decrement(String productId) {
    final index = _lines.indexWhere((line) => line.product.id == productId);
    if (index == -1) return;
    final next = _lines[index].quantity - 1;
    if (next <= 0) {
      _lines.removeAt(index);
    } else {
      _lines[index] = _lines[index].copyWith(quantity: next);
    }
    notifyListeners();
  }

  void remove(String productId) {
    _lines.removeWhere((line) => line.product.id == productId);
    notifyListeners();
  }

  void clear() {
    _lines.clear();
    notifyListeners();
  }
}

class CartScope extends InheritedNotifier<CartController> {
  const CartScope({
    super.key,
    required CartController controller,
    required super.child,
  }) : super(notifier: controller);

  static CartController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<CartScope>();
    assert(scope != null, 'CartScope not found');
    return scope!.notifier!;
  }
}
