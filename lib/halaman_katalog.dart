import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import 'data.dart';

/// Tantangan 1: Stateful karena menyimpan kategori yang sedang dipilih.
class HalamanKatalog extends StatefulWidget {
  const HalamanKatalog({super.key});

  @override
  State<HalamanKatalog> createState() => _HalamanKatalogState();
}

class _HalamanKatalogState extends State<HalamanKatalog> {
  String? _kategori; // null berarti semua kategori

  List<String> get _semuaKategori =>
      daftarProduk.map((p) => p.kategori).toSet().toList();

  @override
  Widget build(BuildContext context) {
    final tampil = _kategori == null
        ? daftarProduk
        : daftarProduk.where((p) => p.kategori == _kategori).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Oleh-Oleh Medan')),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
            child: Row(
              spacing: 8,
              children: [
                for (final k in _semuaKategori)
                  FilterChip(
                    label: Text(k),
                    selected: _kategori == k,
                    onSelected: (pilih) =>
                        setState(() => _kategori = pilih ? k : null),
                  ),
              ],
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Jumlah kolom mengikuti lebar ruang yang tersedia
                final kolom = switch (constraints.maxWidth) {
                  < 600 => 2,
                  < 900 => 3,
                  _ => 4,
                };
                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: kolom,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: tampil.length,
                  itemBuilder: (context, i) => KartuProduk(produk: tampil[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class KartuProduk extends StatelessWidget {
  const KartuProduk({super.key, required this.produk});

  final Produk produk;

  @override
  Widget build(BuildContext context) {
    final teks = Theme.of(context).textTheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.go('/produk/${produk.id}'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                color: produk.warna.withValues(alpha: 0.15),
                // Tantangan 3: Hero menganimasikan ikon ke halaman detail.
                child: Hero(
                  tag: produk.id,
                  child: Icon(produk.ikon, size: 56, color: produk.warna),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    produk.nama,
                    style: teks.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(produk.harga.rupiah, style: teks.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
