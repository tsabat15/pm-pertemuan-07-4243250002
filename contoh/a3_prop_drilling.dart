import 'package:material_ui/material_ui.dart';

// Contoh A.3: prop drilling. Jalankan:
//   flutter run -d chrome -t contoh/a3_prop_drilling.dart
// Perhatikan: jumlah dan fungsi tambah harus diteruskan lewat tiga lapis
// widget (Halaman -> Daftar -> Kartu -> Tombol), padahal hanya Tombol dan
// Badge yang memakainya. Widget perantara ikut berubah bila data bertambah.
void main() => runApp(const MaterialApp(home: Halaman()));

class Halaman extends StatefulWidget {
  const Halaman({super.key});
  @override
  State<Halaman> createState() => _HalamanState();
}

class _HalamanState extends State<Halaman> {
  int _jumlah = 0;
  void _tambah() => setState(() => _jumlah++);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('A.3 Prop drilling'),
          actions: [Badge(label: Text('$_jumlah'), child: const Icon(Icons.shopping_cart))],
        ),
        body: Daftar(jumlah: _jumlah, onTambah: _tambah),
      );
}

class Daftar extends StatelessWidget {
  const Daftar({super.key, required this.jumlah, required this.onTambah});
  final int jumlah;
  final VoidCallback onTambah;
  @override
  Widget build(BuildContext context) => ListView(
        children: [
          for (final nama in ['Bika Ambon', 'Teri Medan', 'Sirup Markisa'])
            Kartu(nama: nama, jumlah: jumlah, onTambah: onTambah),
        ],
      );
}

class Kartu extends StatelessWidget {
  const Kartu({super.key, required this.nama, required this.jumlah, required this.onTambah});
  final String nama;
  final int jumlah;
  final VoidCallback onTambah;
  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          title: Text(nama),
          trailing: Tombol(jumlah: jumlah, onTambah: onTambah),
        ),
      );
}

class Tombol extends StatelessWidget {
  const Tombol({super.key, required this.jumlah, required this.onTambah});
  final int jumlah;
  final VoidCallback onTambah;
  @override
  Widget build(BuildContext context) =>
      FilledButton(onPressed: onTambah, child: Text('Tambah ($jumlah)'));
}
