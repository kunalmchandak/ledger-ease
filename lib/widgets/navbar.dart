import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar(
      {super.key,
      required this.selectedIndex,
      required this.onDestinationSelected});
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: NavigationBar(
        backgroundColor: Colors.black,
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        height: 60,
        indicatorColor: const Color.fromARGB(255, 255, 217, 0),
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.monetization_on),
            icon: Icon(Icons.monetization_on_outlined, color: Colors.white),
            label: 'Transactions',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined, color: Colors.white),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.stacked_bar_chart),
            icon: Icon(Icons.stacked_bar_chart_outlined, color: Colors.white),
            label: 'Stats',
          ),
        ],
      ),
    );
  }
}
