import 'package:flutter_bloc/flutter_bloc.dart';

import 'data.dart';
import 'keranjang_cubit.dart' show KeranjangState;

// Contoh A.5, hanya sebagai pembanding; aplikasi memakai KeranjangCubit.
// Event: "apa yang terjadi", bukan "apa yang harus dilakukan"
sealed class KeranjangEvent {}

final class ProdukDitambah extends KeranjangEvent {
  ProdukDitambah(this.produk);
  final Produk produk;
}

final class KeranjangDikosongkan extends KeranjangEvent {}

class KeranjangBloc extends Bloc<KeranjangEvent, KeranjangState> {
  KeranjangBloc() : super(const KeranjangState()) {
    on<ProdukDitambah>((event, emit) {
      final baru = Map<int, int>.of(state.isi)
        ..update(event.produk.id, (n) => n + 1, ifAbsent: () => 1);
      emit(KeranjangState(baru));
    });
    on<KeranjangDikosongkan>((event, emit) => emit(const KeranjangState()));
  }
}

// Di UI: context.read<KeranjangBloc>().add(ProdukDitambah(p));
