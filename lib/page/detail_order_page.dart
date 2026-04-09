import 'package:flutter/material.dart';
import 'package:state_bloc/main_layout.dart';
import 'package:state_bloc/mainui/home.dart';

class DetailOrderPage extends StatelessWidget {
  final String makanan;
  final String minuman;
  final String jumlahMakanan;
  final String jumlahMinuman;
  final int totalHarga;

  const DetailOrderPage({
    super.key,
    required this.makanan,
    required this.minuman,
    required this.jumlahMakanan,
    required this.jumlahMinuman,
    required this.totalHarga,
  });

Widget _buildReceiptRow(String label, String value, {bool isTotal =
    false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 15,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal ? MainLayout.primaryColor : MainLayout
                .textSubTitleColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 15,
            fontWeight: isTotal ? FontWeight.w900 : FontWeight.bold,
            color: isTotal ? MainLayout.primaryColor : MainLayout
                .textTitleColor,
          ),
        ),
      ],
    ),
  );
}
  @override
Widget build(BuildContext context) {
    return MainLayout(
      title: 'Order Summary',
      showAppBar: true,
      child: Container(
      color: MainLayout.backgroundColor,
      child: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        // Disable overscroll stretch
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(parent:
              ClampingScrollPhysics()), // Smooth tapi gak mantul
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green,
                    size: 80,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Order Successful!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: MainLayout.textTitleColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Here are your order details',
                  style: TextStyle(
                    fontSize: 14,
                    color: MainLayout.textSubTitleColor,
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'RECEIPT',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                            color: MainLayout.labelColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Divider(thickness: 1, color: MainLayout
                          .inputBorderColor),
                      const SizedBox(height: 16),

                      const Text(
                        'Food Details',
                        style: TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 16, color: MainLayout
                                .accentOrange),
                      ),
                      const SizedBox(height: 8),
                      _buildReceiptRow('Item Name', makanan),
                      _buildReceiptRow('Quantity', 'x$jumlahMakanan'),

                      const SizedBox(height: 16),
                      const Divider(thickness: 1, color: MainLayout
                          .inputBorderColor),
                      const SizedBox(height: 16),

                      const Text(
                        'Drink Details',
                        style: TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 16, color: Colors.blue),
                      ),
                      const SizedBox(height: 8),
                      _buildReceiptRow('Item Name', minuman),
                      _buildReceiptRow('Quantity', 'x$jumlahMinuman'),

                      const SizedBox(height: 16),
                      const Divider(thickness: 1.5, color: Colors
                          .black12),
                      const SizedBox(height: 16),

                      _buildReceiptRow(
                        'Total Price',
                        'Rp $totalHarga',
                        isTotal: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(
                            recentOrder: {
                              'makanan': makanan,
                              'minuman': minuman,
                              'jumlahMakanan': jumlahMakanan,
                              'jumlahMinuman': jumlahMinuman,
                              'totalHarga': totalHarga,
                            },
                          ),
                        ),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18
                          ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      backgroundColor: MainLayout.primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 2,
                      shadowColor: MainLayout.primaryColor.withOpacity
                          (0.5),
                    ),
                    child: const Text(
                      'Back to Home',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}