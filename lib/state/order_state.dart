abstract class OrderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {
  final String makanan;
  final String minuman;
  final int jumlahMakanan;
  final int jumlahMinuman;
  final int totalHarga;

  OrderSuccess({
    required this.makanan,
    required this.minuman,
    required this.jumlahMakanan,
    required this.jumlahMinuman,
    required this.totalHarga,
  });

  Map<String, dynamic> toMap() => {
    'makanan': makanan,
    'minuman': minuman,
    'jumlahMakanan': jumlahMakanan,
    'jumlahMinuman': jumlahMinuman,
    'totalHarga': totalHarga,
  };

@override
  List<Object?> get props => [
    makanan, minuman, jumlahMakanan, jumlahMinuman, totalHarga
  ];
}

class OrderError extends OrderState {
  final String message;
  OrderError({required this.message});

  @override
  List<Object?> get props => [message];
}