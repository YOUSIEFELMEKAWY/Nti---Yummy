import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yummy/Views/restaurant_details.dart';
import 'package:yummy/api/mock_yummy_service.dart';
import 'package:yummy/components/categories_item_builder.dart';
import 'package:yummy/components/post_item_builder.dart';
import 'package:yummy/components/restaurant_item_builder.dart';
import 'package:yummy/models/cart_manager.dart';
import 'package:yummy/models/food_category.dart';
import 'package:yummy/models/post.dart';

import '../models/restaurant.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    // state -> start call -> await call ->done  -> maybe {error}
    return FutureBuilder(
      future: MockYummyService().getExploreData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(child: CircularProgressIndicator());
        } else {
          final restaurants = snapshot.data?.restaurants ?? [];
          final categories = snapshot.data?.categories ?? [];
          final posts = snapshot.data?.friendPosts ?? [];

          return SingleChildScrollView(
            child: Column(
              children: [
                //all restaurants -> scroll from right to left
                RestaurantSection(restaurants: restaurants),
                //all categories -> scroll from right to left
                CategoriesSection(categories: categories),
                //posts -> scroll from up to down
                PostsSection(posts: posts),
              ],
            ),
          );
        }
      },
    );
  }
}

class RestaurantSection extends StatelessWidget {
  final List<Restaurant> restaurants;
   RestaurantSection({super.key, required this.restaurants});

  CartManager cartManager = CartManager();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Food for me',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: restaurants.length,
            itemBuilder:
                (context, index) => SizedBox(
                  width: 250,
                  height: 300,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => RestaurantDetails(
                                restaurants: restaurants,
                                index: index,
                                cartManager: cartManager,
                              ),
                        ),
                      );
                    },
                    child: RestaurantItemBuilder(
                      restaurant: restaurants[index],
                      cartManager: CartManager(),
                    ),
                  ),
                ),
          ),
        ),
      ],
    );
  }
}

class CategoriesSection extends StatelessWidget {
  final List<FoodCategory> categories;
  const CategoriesSection({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Categories',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        SizedBox(
          height: 350,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 250,
                height: 300,
                child: CategoriesItemBuilder(foodCategory: categories[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

class PostsSection extends StatelessWidget {
  final List<Post> posts;
  const PostsSection({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Friends Activity',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        ListView.builder(
          itemCount: posts.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return SizedBox(
              height: 120,
              child: PostItemBuilder(post: posts[index]),
            );
          },
        ),
      ],
    );
  }
}
