import 'package:flutter/material.dart';
import 'package:yummy/models/food_category.dart';

class CategoriesItemBuilder extends StatelessWidget {
  final FoodCategory foodCategory;
  const CategoriesItemBuilder({super.key, required this.foodCategory});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(foodCategory.imageUrl),
              ),
              Positioned(
                top: 20,
                left: 20,
                child: Text(
                  'Yummy',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              Positioned(
                bottom: 80,
                right: 10,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Text(
                    'Yummy',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
              ),

            ],
          ),
          ListTile(
            title: Text(foodCategory.name),
            subtitle: Text('${foodCategory.numberOfRestaurants} places'),
          ),
        ],
      ),
    );
  }
}
