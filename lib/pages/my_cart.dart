import 'dart:convert';
import 'dart:core';
// import 'dart:js_interop';

import 'package:online_market/pages/my_orders.dart';
import 'package:online_market/resources/resources.dart';
import 'package:online_market/widgets/bottom_navbar.dart';
import 'package:online_market/widgets/calculation.dart';
import 'package:online_market/widgets/custom_card.dart';
import '../services/api_service.dart';
import 'package:online_market/models/card_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyCard extends StatefulWidget {
  const MyCard({super.key});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  List<Order> orders = [];
  // List<double> prices = [1.0, 2.0, 3.0, 4.0];
  late double bagTotal = 0.0;
  List<Order>? previousOrders; // Initialize with a default value
  // Initialize with a default value
  // late double totalSum = 0.0;
  @override
  void initState() {
    super.initState();
    fetchCard();
  }

  Future<void> fetchCard() async {
    List<Order> fetchedOrders = await get_card();
    setState(() {
      if (fetchedOrders.isNotEmpty) {
        orders = fetchedOrders;
        bagTotal = calculateTotal();
        previousOrders =
            fetchedOrders; // Update previousOrders if new data is available
      } else if (previousOrders != null) {
        // Use previousOrders if new data is null
        orders = previousOrders!;
        bagTotal = calculateTotal();
      }
    });
  }

  double calculateTotal() {
    double total = 0.0;
    for (Order order in orders) {
      total += order.price * order.amount;
    }
    return total;
  }

  Future<List<Order>> get_card() async {
    ApiService _apiService = ApiService();
    Map<String, String> headersUrl = await _apiService.headersAuthorization();
    final String baseUrl = await _apiService.baseUrl;

    List<int> order_set = [];

    final response = await http.get(
      Uri.parse('$baseUrl/product/card/'),
      headers: headersUrl,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      orders.clear(); // Clear existing orders before updating
      bagTotal = 0.0; // Initialize bagTotal

      for (Map i in data['order_item']) {
        if (!order_set.contains(i['id'])) {
          String imageUrl = i['image'];
          String image = "$baseUrl$imageUrl";
          Order order = Order(
            id: i['id'],
            name: i['name'],
            subname: i['subname'],
            price: i['price'],
            image: image,
            amount: i['amount'],
          );
          orders.add(order);
          order_set.add(i['id']);
          bagTotal += i['price'] * i['amount'];
        }
      }
    }

    return orders;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 265),
              child: Container(
                height: 60,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.black12),
                child: Image.asset(Images.profilePhoto),
              ),
            ),
            const Text(
              'My Cart',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.62,
              child: Center(
                child: FutureBuilder(
                    future: get_card(),
                    builder: (context, AsyncSnapshot<List<Order>> order) {
                      if (order.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator.adaptive();
                      } else {
                        return ListView.builder(
                          itemCount: order.data!.length,
                          itemBuilder: (context, index) {
                            return CustomCard(
                              model: Order(
                                  image: order.data![index].image,
                                  id: order.data![index].id,
                                  name: order.data![index].name.toString(),
                                  subname:
                                      order.data![index].subname.toString(),
                                  price: order.data![index].price,
                                  amount: order.data![index].amount),
                              // subtitle: Text(order.data![index].name.toString()),
                              // title: Text(order.data![index].subname.toString()),
                            );
                          },
                        );
                      }
                    }),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Column(children: [
                          // Calculation(
                          //   title: 'Subtotal:',

                          //   // price: '\$${774}',
                          //   price: '\$${bagTotal.toStringAsFixed(2)}',
                          // ),
                          // Calculation(
                          //   title: 'Shipping:',
                          //   //   // price: '\$${774}',

                          //   price: '\$${shipping.toStringAsFixed(2)}',
                          // ),
                          Calculation(
                            title: 'Total Price:',
                            //   // price: '\$${774}',

                            price: '\$${bagTotal.toStringAsFixed(2)}',
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    ApiService _apiService = ApiService();

                    _apiService.postCheckOut(bagTotal.toInt());
                   
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavbar()));
                    orders.clear();
                    bagTotal = 0.0;
                    _showDialog('Successful', 'Your item successfully ordered');

                    // setState(() {
                    //   orders.clear();
                    //   bagTotal = 0.0;
                    // });
                  },
                  child: Container(
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        'Proceed to Checkout',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Judson'),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
    void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
