import 'package:flutter/material.dart';
import 'package:state_bloc/main_layout.dart';
import 'package:state_bloc/page/detail_order_page.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedFood;
  String? _selectedDrink;
  int _foodQuantity = 1;
  int _drinkQuantity = 1;

  final List<String> _foods = [
    'Nasi Goreng',
    'Mie Goreng',
    'Ayam Bakar',
    'Sate Ayam'
  ];
  final List<String> _drinks = ['Es Teh', 'Es Jeruk', 'Kopi', 'Air Mineral'];

  final Map<String, int> _prices = {
    'Nasi Goreng': 15000,
    'Mie Goreng': 12000,
    'Ayam Bakar': 20000,
    'Sate Ayam': 18000,
    'Es Teh': 5000,
    'Es Jeruk': 7000,
    'Kopi': 8000,
    'Air Mineral': 4000,
  };

  void _submitOrder() {
    if (_formKey.currentState!.validate()) {
      int total = (_prices[_selectedFood] ?? 0) * _foodQuantity +
          (_prices[_selectedDrink] ?? 0) * _drinkQuantity;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailOrderPage(
            orderData: {
              'makanan': _selectedFood,
              'jumlahMakanan': _foodQuantity,
              'minuman': _selectedDrink,
              'jumlahMinuman': _drinkQuantity,
              'totalHarga': total,
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'New Order',
      showAppBar: true,
      child: Container(
        color: MainLayout.backgroundColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildSectionTitle('Select Food'),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _selectedFood,
                    decoration: _inputDecoration(
                        'Food Item', Icons.restaurant_menu_rounded),
                    items: _foods.map((food) {
                      return DropdownMenuItem(
                        value: food,
                        child: Text(food),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedFood = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) return 'Please select your food';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildQuantitySelector('Food Quantity', _foodQuantity, (val) {
                    setState(() {
                      _foodQuantity = val;
                    });
                  }),
                  const SizedBox(height: 32),
                  _buildSectionTitle('Select Drink'),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _selectedDrink,
                    decoration: _inputDecoration(
                        'Drink Item', Icons.local_drink_rounded),
                    items: _drinks.map((drink) {
                      return DropdownMenuItem(
                        value: drink,
                        child: Text(drink),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedDrink = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) return 'Please select your drink';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildQuantitySelector('Drink Quantity', _drinkQuantity,
                      (val) {
                    setState(() {
                      _drinkQuantity = val;
                    });
                  }),
                  const SizedBox(height: 48),
                  ElevatedButton(
                    onPressed: () {
                      _submitOrder();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MainLayout.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Review Order',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: MainLayout.textTitleColor,
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
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
    );
  }

  Widget _buildQuantitySelector(
      String label, int value, Function(int) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: MainLayout.textSubTitleColor,
            fontSize: 15,
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: value > 1 ? () => onChanged(value - 1) : null,
              icon: const Icon(
                Icons.remove_circle_outline_rounded,
                color: MainLayout.primaryColor,
              ),
            ),
            Text(
              '$value',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () => onChanged(value + 1),
              icon: const Icon(
                Icons.add_circle_outline_rounded,
                color: MainLayout.primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
