import 'package:flutter/material.dart';
import 'package:yummy/models/cart_manager.dart';
import 'package:yummy/models/restaurant.dart';

class RestaurantItemBuilder extends StatelessWidget {
  final Restaurant restaurant;
  final CartManager cartManager;
  const RestaurantItemBuilder({super.key, required this.restaurant, required this.cartManager});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(
              restaurant.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 100,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                restaurant.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(restaurant.address),
            ),
          ),
        ],
      ),
    );
  }
}
