import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:babyformula/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;

  testWidgets('Little Leaf home is visible', (tester) async {
    await tester.pumpWidget(const LittleLeafApp());
    await tester.pump();

    expect(find.text('Little Leaf'), findsWidgets);
    expect(find.text('Home'), findsWidgets);
    expect(find.text('A calmer tin of milk'), findsOneWidget);
  });
}
