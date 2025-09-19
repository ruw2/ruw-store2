import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/cart_provider.dart';
import 'package:shopping_app/screen/cartwidget.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping Cart"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<CartProvider>().clearCart();
            },
            icon: const Icon(Icons.delete_forever, color: Colors.red),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (final item in provider.cartList) CartWidget(product: item),
          ],
        ),
      ),
    );
  }
}
