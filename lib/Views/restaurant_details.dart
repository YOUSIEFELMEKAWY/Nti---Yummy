import 'package:flutter/material.dart';
import 'package:yummy/models/cart_manager.dart';
import '../components/drawer_content.dart';
import '../components/restaurant_list_item_builder.dart';
import '../models/restaurant.dart';

class RestaurantDetails extends StatefulWidget {
  final List<Restaurant> restaurants;
  final int index;
  final CartManager cartManager;
  const RestaurantDetails({
    super.key,
    required this.restaurants,
    required this.index,
    required this.cartManager,
  });

  @override
  State<RestaurantDetails> createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,

            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Image.asset(widget.restaurants[widget.index].imageUrl),
                    ),
                  ),
                  Positioned(
                    bottom: -0,
                    left: 30,
                    child: CircleAvatar(
                      backgroundColor: Colors.pink.withOpacity(0.2),
                      radius: 30.0,
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 30)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(widget.restaurants[widget.index].name, style: theme.displaySmall),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(widget.restaurants[widget.index].address, style: theme.bodyMedium),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Ratting: ${widget.restaurants[widget.index].rating} ★ | Distance: ${widget.restaurants[widget.index].distance} miles',
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(widget.restaurants[widget.index].attributes),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 50)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('Menu', style: theme.displaySmall),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder:
                          (context) => _BottomSheetContent(
                            restaurant: widget.restaurants[index],
                            cartManager: widget.cartManager,
                            update: () {
                              setState(() {

                              });
                            },
                          ),
                    );
                  },
                  child: RestaurantListItemBuilder(
                    restaurant: widget.restaurants[index],
                  ),
                ),
              );
            }, childCount: widget.restaurants.length),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()
        {
          setState(() {
          });
        },
        label: Row(
          children: [
            Text('${widget.cartManager.items.length}'),
            Icon(Icons.shopping_cart_checkout),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: DrawerContent(cartManager: widget.cartManager,),
      ),
    );
  }
}

class _BottomSheetContent extends StatefulWidget {
  final Restaurant restaurant;
  final CartManager cartManager;
  final VoidCallback update;

  const _BottomSheetContent({required this.restaurant, required this.cartManager,
    required this.update,
  });

  @override
  State<_BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<_BottomSheetContent> {
  int quantity = 1;

  void increment() {
    setState(() {
      quantity++;
    });
  }

  void decrement() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 5,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Text(widget.restaurant.name, style: theme.textTheme.titleLarge),
          const SizedBox(height: 10),
          Text(widget.restaurant.address, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 10),
          Text(
            'Rating: ${widget.restaurant.rating} ★ | Distance: ${widget.restaurant.distance} miles',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 10),
          Text(widget.restaurant.attributes, style: theme.textTheme.bodySmall),
          const SizedBox(height: 20),
          Image.asset(widget.restaurant.imageUrl),
          const SizedBox(height: 20),
          Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: decrement,
                    icon: const Icon(Icons.remove),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: Text(
                      quantity.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  IconButton(onPressed: increment, icon: const Icon(Icons.add)),
                ],
              ),
              SizedBox(width: 30),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {

                      widget.cartManager.addItem(CartItem(id: widget.restaurant.name, name: widget.restaurant.name, price: widget.restaurant.rating, quantity: quantity));

                    widget.update();
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text('Add to Cart'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
