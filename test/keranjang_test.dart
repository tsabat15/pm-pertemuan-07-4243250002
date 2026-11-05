import 'package:flutter_test/flutter_test.dart';
import 'package:katalog_oleh_oleh/data.dart';
import 'package:katalog_oleh_oleh/keranjang_cubit.dart';

void main() {
  test('tambah dan kurangi memperbarui jumlah dan total', () async {
    final c = KeranjangCubit();

    c.tambah(daftarProduk[0]); // Kopi Sidikalang 45.000
    c.tambah(daftarProduk[0]);
    c.tambah(daftarProduk[1]); // Bolu Meranti 80.000
    expect(c.state.jumlahItem, 3);
    expect(c.state.total, 45000 * 2 + 80000);

    c.kurangi(daftarProduk[0]);
    expect(c.state.isi[1], 1);

    await c.close();
  });

  test('setiap perubahan menghasilkan objek state baru', () async {
    final c = KeranjangCubit();
    final lama = c.state;

    c.tambah(daftarProduk[0]);

    expect(identical(lama, c.state), isFalse);
    expect(lama.isi, isEmpty); // state lama tidak ikut berubah

    await c.close();
  });

  test('kurangi menghapus item saat jumlahnya habis', () async {
    final c = KeranjangCubit()..tambah(daftarProduk[2]);

    c.kurangi(daftarProduk[2]);

    expect(c.state.isi, isEmpty);
    expect(c.state.total, 0);

    await c.close();
  });

  test('checkout mengosongkan isi dan menaikkan penghitung', () async {
    final c = KeranjangCubit()..tambah(daftarProduk[0]);

    c.checkout();

    expect(c.state.jumlahItem, 0);
    expect(c.state.jumlahCheckout, 1);

    await c.close();
  });
}
