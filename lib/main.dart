import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/shell.dart';
import 'state/cart_controller.dart';
import 'theme/app_colors.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const LittleLeafApp());
}

class LittleLeafApp extends StatefulWidget {
  const LittleLeafApp({super.key});

  @override
  State<LittleLeafApp> createState() => _LittleLeafAppState();
}

class _LittleLeafAppState extends State<LittleLeafApp> {
  final CartController _cart = CartController();

  @override
  void dispose() {
    _cart.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CartScope(
      controller: _cart,
      child: MaterialApp(
        title: 'Little Leaf',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const AppShell(),
        builder: (context, child) {
          return ColoredBox(color: AppColors.white, child: child);
        },
      ),
    );
  }
}
