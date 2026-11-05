import 'package:flutter_test/flutter_test.dart';
import 'package:katalog_oleh_oleh/data.dart';
import 'package:katalog_oleh_oleh/keranjang_model.dart';

void main() {
  test('tambah dan kurangi memperbarui jumlah dan total', () {
    final k = KeranjangModel();
    var notifikasi = 0;
    k.addListener(() => notifikasi++);

    k.tambah(daftarProduk[0]); // Kopi Sidikalang 45.000
    k.tambah(daftarProduk[0]);
    k.tambah(daftarProduk[1]); // Bolu Meranti 80.000
    expect(k.jumlahItem, 3);
    expect(k.total, 45000 * 2 + 80000);

    k.kurangi(daftarProduk[0]);
    expect(k.jumlahDari(1), 1);
    expect(notifikasi, 4);
  });

  test('kurangi menghapus item saat jumlahnya habis', () {
    final k = KeranjangModel()..tambah(daftarProduk[2]);

    k.kurangi(daftarProduk[2]);

    expect(k.item, isEmpty);
    expect(k.total, 0);
  });

  test('kosongkan menghapus semua item', () {
    final k = KeranjangModel()
      ..tambah(daftarProduk[0])
      ..tambah(daftarProduk[1]);

    k.kosongkan();

    expect(k.jumlahItem, 0);
  });
}
