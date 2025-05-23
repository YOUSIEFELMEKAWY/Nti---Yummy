import 'package:flutter/material.dart';
import 'package:yummy/Views/account_view.dart';
import 'package:yummy/Views/explore_view.dart';
import 'package:yummy/Views/orders_view.dart';


class HomeView extends StatefulWidget {
  final VoidCallback changeTheme;
  const HomeView({super.key, required this.changeTheme});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  void changeSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> views = [
    ExploreView(),
    OrdersView(),
    AccountView(),
    // CategoriesItemBuilder(foodCategory: categories[0]),
    // PostItemBuilder(post: posts[0]),
    // CategoriesItemBuilder(foodCategory: categories[6]),
  ];
  final List<Widget> _destinations = [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.menu_outlined),
      selectedIcon: Icon(Icons.menu),
      label: 'Menu',
    ),
    NavigationDestination(
      icon: Icon(Icons.notification_add_outlined),
      selectedIcon: Icon(Icons.notification_add),
      label: 'Notification',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yummy'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: widget.changeTheme,
            icon: Icon(Icons.nightlight_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IndexedStack(index: _selectedIndex, children: views),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: _destinations,
        selectedIndex: _selectedIndex,
        onDestinationSelected: changeSelectedIndex,
      ),
    );
  }
}
