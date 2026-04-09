import 'package:flutter/material.dart';
import 'package:state_bloc/main_layout.dart';
import 'package:state_bloc/page/detail_order_page.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final TextEditingController makananController = TextEditingController();  
  final TextEditingController minumanController = TextEditingController();
  final TextEditingController jumlahMakananController = TextEditingController();
  final TextEditingController jumlahMinumanController = TextEditingController();
  int totalHarga = 0;

  final _formKey = GlobalKey<FormState>();

  void calculateTotalPrice() {
    int jumlahMakanan = int.tryParse(jumlahMakananController.text) ?? 0;
    int jumlahMinuman = int.tryParse(jumlahMinumanController.text) ?? 0;
    
    setState(() {
      totalHarga = (jumlahMakanan * 32000) + (jumlahMinuman * 5000);
    });
  }

  @override
  void dispose() {
    makananController.dispose();
    minumanController.dispose();
    jumlahMakananController.dispose();
    jumlahMinumanController.dispose();
    super.dispose();
  }

  Widget _buildInputDecoration({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    required String? errorMessage,
  }){
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: MainLayout.labelColor),
        prefixIcon: Icon(icon, color: MainLayout.primaryColor),
        filled: true,
        fillColor: MainLayout.inputFillColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: MainLayout.inputBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: MainLayout.primaryColor, width: 2),
        ),
        errorText: errorMessage,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorMessage;
        }
        return null;
      },
    );
  }


  @override
Widget build(BuildContext context) {
  return MainLayout(
    title: 'Order Menu',
    showAppBar: true,
    child: Container(
      color: MainLayout.backgroundColor,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0,
              vertical: 32.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'What would you like to have?',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: MainLayout.textTitleColor,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Fill in the details below to complete your order.'
                      ,
                  style: TextStyle(
                    fontSize: 14,
                    color: MainLayout.textSubTitleColor,
                  ),
                ),
                const SizedBox(height: 32),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.fastfood_rounded, color:
                              MainLayout.accentOrange),
                          SizedBox(width: 8),
                          Text(
                            'Food Details',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: MainLayout.textTitleColor,
                            ),
                          ),
                        ],
                      ),
                     const SizedBox(height: 16),
                      _buildInputDecoration(
                        controller: makananController,
                        label: 'Food Name',
                        icon: Icons.lunch_dining_rounded,
                        errorMessage: 'Please enter your food order',
                      ),
                      const SizedBox(height: 16),
                      _buildInputDecoration(
                        controller: jumlahMakananController,
                        label: 'Quantity (Food)',
                        icon: Icons.format_list_numbered_rounded,
                        keyboardType: TextInputType.number,
                        errorMessage: 'Please enter food quantity',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.local_drink_rounded, color:
                              Colors.blue),
                          SizedBox(width: 8),
                          Text(
                            'Drink Details',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: MainLayout.textTitleColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildInputDecoration(
                        controller: minumanController,
                        label: 'Drink Name',
                        icon: Icons.coffee_rounded,
                        errorMessage: 'Please enter your drink order'
                            ,
                      ),
                      const SizedBox(height: 16),
                      _buildInputDecoration(
                        controller: jumlahMinumanController,
                        label: 'Quantity (Drink)',
                        icon: Icons.format_list_numbered_rounded,
                        keyboardType: TextInputType.number,
                        errorMessage: 'Please enter drink quantity',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      calculateTotalPrice();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailOrderPage(
                            jumlahMakanan: jumlahMakananController
                                .text,
                            jumlahMinuman: jumlahMinumanController
                                .text,
                            makanan: makananController.text,
                            minuman: minumanController.text,
                            totalHarga: totalHarga,
                          ),
                        ),
                      );
                    }
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
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.receipt_long_rounded),
                      SizedBox(width: 8),
                      Text(
                        'Place Order',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}