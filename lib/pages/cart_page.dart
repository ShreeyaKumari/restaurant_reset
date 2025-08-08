import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/cart_provider.dart';
import '../utils/colors.dart';
import '../utils/models.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Your Cart")),
      body: cart.items.isEmpty
          ? const Center(child: Text("Your cart is empty."))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final dish = cart.items.keys.elementAt(index);
                      final quantity = cart.items[dish]!;

                      return ListTile(
                        leading: SizedBox(
                          width: 60,
                          height: 60,
                          child: Image.asset(
                            dish.imageUrl, // ✅ Use local asset image
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image),
                          ),
                        ),
                        title: Text(dish.name),
                        subtitle: Text(
                            "₹${dish.price.toStringAsFixed(2)} x $quantity"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => cart.decreaseQuantity(dish),
                            ),
                            Text(quantity.toString()),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => cart.increaseQuantity(dish),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "Total: ₹${cart.totalPrice.toStringAsFixed(2)}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.green),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Order placed successfully!")),
                          );
                          cart.clearCart();
                        },
                        child: const Text("Order Now"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
