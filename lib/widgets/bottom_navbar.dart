import 'package:online_market/pages/my_cart.dart';
import 'package:online_market/pages/my_profile.dart';
import 'package:online_market/resources/resources.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 2;

  static const List<Widget> _screens = <Widget>[
    MyCard(),
     Text(
      'index:1 Orders',
      style: TextStyle(color: Colors.black, fontSize: 50),
    ),
   
    MyProfile(),
  ];
  void _itemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Image.asset(
                Images.home,
                height: 50,
                width: 40,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
            icon: Image.asset(
              Images.shoppingCart,
              height: 50,
            ),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
              icon: Image.asset(
                Images.user,
                height: 50,
              ),
              label: 'My Profile'),
        ],
        onTap: _itemTapped,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
      ),
    );
  }
}
