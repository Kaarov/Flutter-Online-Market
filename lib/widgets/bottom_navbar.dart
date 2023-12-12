import 'dart:convert';
import 'dart:core';

import 'package:online_market/data/dummy_data.dart';
import 'package:online_market/models/product_model.dart';
import 'package:online_market/pages/home.dart';
import 'package:online_market/pages/my_orders.dart';
import 'package:online_market/pages/my_profile.dart';
import 'package:online_market/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:online_market/services/api_service.dart';
import 'package:http/http.dart' as http;

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key,});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 0;
  List<Product> products = [];

  Future<void> fetchCard() async {
    List<Product> fetchedOrders = await get_card();
    setState(() {
      products = fetchedOrders;
    });
  }

  Future<List<Product>> get_card() async {
    ApiService _apiService = ApiService();
    Map<String, String> headersUrl = await _apiService.headersAuthorization();
    final String baseUrl = await _apiService.baseUrl;

    List<int> order_set = [];

    final response = await http.get(
      Uri.parse('$baseUrl/product/product/'),
      headers: headersUrl,
    );

    if (response.statusCode == 200) {
      // final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> data = jsonDecode(response.body);

      products.clear();

      print(data);

      for (Map i in data) {
        if (!order_set.contains(i['id'])) {
          String imageUrl = i['image'];
          String image = "$baseUrl$imageUrl";
          Product order = Product(
            id: i['id'],
            title: i['name'],
            smaltitle: i['subname'],
            cost: i['price'],
            image: image,
            description: i['description'],
          );
          products.add(order);
          order_set.add(i['id']);
        }
      }
    }

    return products;
  }

  static final List<Widget> _screens = <Widget>[
    // Home(products: dummyProduct,),
    Home(),
    MyOrders(),
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
            // icon: Icon(I),
            icon: Image.asset(
              Images.purse3,
              height: 50,
            ),
            label: 'My Orders',
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
