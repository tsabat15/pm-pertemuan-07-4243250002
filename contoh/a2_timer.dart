import 'dart:async';
import 'package:material_ui/material_ui.dart';

// Contoh A.2: ephemeral state dan Timer. Jalankan:
//   flutter run -d chrome -t contoh/a2_timer.dart
// Percobaan: hapus (beri komentar) baris _timer.cancel() di dispose(),
// buka halaman Timer, tekan Mulai, lalu kembali. Perhatikan konsol: pesan
// "tik" tetap tercetak walau halamannya sudah ditutup (kebocoran).
void main() => runApp(const MaterialApp(home: Beranda()));

class Beranda extends StatelessWidget {
  const Beranda({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Beranda')),
        body: Center(
          child: FilledButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const HalamanTimer())),
            child: const Text('Buka halaman Timer'),
          ),
        ),
      );
}

class HalamanTimer extends StatefulWidget {
  const HalamanTimer({super.key});
  @override
  State<HalamanTimer> createState() => _HalamanTimerState();
}

class _HalamanTimerState extends State<HalamanTimer> {
  int _detik = 0;
  Timer? _timer;

  void _mulai() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      debugPrint('tik ${_detik + 1}, mounted: $mounted');
      setState(() => _detik++);
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // hapus baris ini untuk percobaan
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Timer')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$_detik detik',
                  style: Theme.of(context).textTheme.displayMedium),
              const SizedBox(height: 16),
              FilledButton(onPressed: _mulai, child: const Text('Mulai')),
            ],
          ),
        ),
      );
}
