import 'package:coralcartseller/screen/home_screen.dart';
import 'package:coralcartseller/screen/order_screen.dart';
import 'package:coralcartseller/screen/profile_screen.dart';
import 'package:coralcartseller/screen/review_screen.dart';
import 'package:flutter/material.dart';

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _selectedIndex = 0;

  // Define your screens here
   List<Widget> _screens = [

    const HomeScreen(),
    OrderScreen(),
    ReviewPage(),
    ProfileScreen(),

    
  ];

 
  // Handle item selection in the bottom navigation bar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CORALCART SELLER', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25,color: Colors.white),),
         backgroundColor: Colors.teal,
         centerTitle: true,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: 'Order',
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.rate_review),
            label: 'Review',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}