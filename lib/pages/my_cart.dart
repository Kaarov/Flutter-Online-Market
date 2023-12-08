import 'dart:convert';
import 'dart:core';

import 'package:online_market/resources/resources.dart';
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
  // late double subTotalPrice = 500; // Initialize with a default value
  // late double shipping = 0.0; // Initialize with a default value
  late double bagTotal = 0.0; // Initialize with a default value
  // late double totalSum = 0.0;
  

  //  @override
  // void initState() {
  //   super.initState();
  //   // Initialize the late variables in initState

  //   // initializeValues();
  //   getCard();
  // }
  // Future<void> getCard() async {
  //   // Fetch orders and update the UI
  //   List<Order> orders = await get_card(); // Replace with your actual function
  //   // setState(() {
  //   //   calculateTotal(orders);
  //   // });
  // }

  // void calculateTotal(List<Order> orders) {

  //   for (Order order in orders) {
  //     bagTotal += order.price * order.amount;
  //   }

  //   print('Bag Total: \$${bagTotal.toStringAsFixed(2)}');
  // }

  // Future<List<Order>> get_card() async {
  //   ApiService _apiService = ApiService();
  //   Map<String, String> headersUrl = await _apiService.headersAuthorization();
  //   final String baseUrl = await _apiService.baseUrl;

  //   List<int> order_set = []; //wfkrmkmrk

  //   final response = await http.get(
  //     Uri.parse('$baseUrl/product/card/'),
  //     headers: headersUrl,
  //   );

  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> data = jsonDecode(response.body);
  //     // orders.clear();

  //     for (Map i in data['order_item']) {
  //       if (!order_set.contains(i['id'])) {
  //         String imageUrl = i['image'];
  //         String image = "${baseUrl}${imageUrl}";
  //         Order order = Order(
  //             id: i['id'],
  //             name: i['name'],
  //             subname: i['subname'],
  //             price: i['price'],
  //             image: image,
  //             amount: i['amount']);
  //         orders.add(order);
  //         order_set.add(i['id']);
  //         bagTotal += i['price'] * i['amount'];
  //         // prices[0] = 500;
  //         // print(prices);
  //       }
  //     }

  //     print(bagTotal);
  //     // setState(() {});
  //   }

    // MyCard._MyCardState = 900;

    // subTotalPrice = 9000;
    //  double newSubTotalPrice = 9000;
    //   setState(() {
    //   subTotalPrice = newSubTotalPrice;
    // });

    // // setState(() {

    // });

    // for (Order order in orders) {
    //   subTotalPrice += order.price * order.amount;
    // }

    // shipping = subTotalPrice * 0.05; // Assuming a fixed shipping cost, adjust as needed
    // bagTotal = subTotalPrice + shipping;
    // totalSum = shipping + subTotalPrice;

    // print('Subtotal: \$${subTotalPrice.toStringAsFixed(2)}');
    // print('Shipping: \$${shipping.toStringAsFixed(2)}');
    // print('Bag Total: \$${bagTotal.toStringAsFixed(2)}');

    // subTotalPrice = 0.0;
    // shipping = 0.05; // Assuming a fixed shipping cost, adjust as needed
    // bagTotal = subTotalPrice + shipping;

    // for (Order order in orders) {
    //   subTotalPrice += order.price * order.amount;
    // }

    // shipping = subTotalPrice * shipping;
    // totalSum = shipping + subTotalPrice;

    // print('Subtotal: \$${subTotalPrice.toStringAsFixed(2)}');
    // print('Shipping: \$${shipping.toStringAsFixed(2)}');
    // print('Bag Total: \$${bagTotal.toStringAsFixed(2)}');

  //   return orders;
  // }

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
              height: MediaQuery.of(context).size.height * 0.55,
              child: FutureBuilder(
                  future: get_card(),
                  builder: (context, AsyncSnapshot<List<Order>> order) {
                    if (order.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator.adaptive();
                    } else {
                      return ListView.builder(
                        itemCount: order.data!.length,
                        itemBuilder: (context, index) {
                          return CustomCard(
                            model: Order(
                                image: order.data![index].image,
                                id: order.data![index].id,
                                name: order.data![index].name.toString(),
                                subname: order.data![index].subname.toString(),
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
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(children: [
                      Calculation(
                        title: 'Subtotal:',
                        
                        // price: '\$${774}',
                        price: '\$${bagTotal.toStringAsFixed(2)}',
                      ),
                      // Calculation(
                      //   title: 'Shipping:',
                      //   // price: '\$${774}',

                      //   price: '\$${prices[1].toStringAsFixed(2)}',
                      // ),
                      // Calculation(
                      //   title: 'BagTotal:',
                      //   // price: '\$${774}',

                      //   price: '\$${prices[2].toStringAsFixed(2)}',
                      // ),
                    ]),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      
                    });
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
}
