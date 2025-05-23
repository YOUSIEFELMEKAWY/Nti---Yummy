import 'package:flutter/material.dart';

import '../models/restaurant.dart';

class RestaurantListItemBuilder extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantListItemBuilder({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(restaurant.name,style: theme.bodyLarge,),
              Text(restaurant.attributes,style: theme.bodyMedium,),
              Text('${restaurant.rating} 👍',style: theme.bodyLarge,)


            ],
          ),
          SizedBox(
            height: 100,
            width: 100,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.asset(restaurant.imageUrl),
                ),
                Positioned(
                  bottom: -10,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Text('Add'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
