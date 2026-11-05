import 'package:flutter_test/flutter_test.dart';
import 'package:katalog_oleh_oleh/keranjang_model.dart';
import 'package:katalog_oleh_oleh/main.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Tambah dari detail, badge, total, lalu checkout', (
    tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => KeranjangModel(),
        child: const KatalogApp(),
      ),
    );

    await tester.tap(find.text('Kopi Sidikalang'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tambah ke keranjang'));
    await tester.pump();
    expect(find.text('Tambah lagi (1 di keranjang)'), findsOneWidget);
    expect(find.text('1'), findsOneWidget); // label badge

    await tester.tap(find.text('Keranjang'));
    await tester.pumpAndSettle();
    expect(find.text('Total Rp45.000'), findsOneWidget);

    await tester.tap(find.text('Checkout'));
    await tester.pump();
    expect(find.text('Pesanan dibuat (simulasi)'), findsOneWidget);
    expect(find.text('Keranjang masih kosong'), findsOneWidget);
  });
}
