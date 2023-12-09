import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:online_market/models/card_models.dart';
import 'package:online_market/resources/resources.dart';
import 'package:online_market/services/api_service.dart';
import 'package:online_market/widgets/custom_card_baizak.dart';
// import 'package:shop/widgets/my_orders_by_date.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  List<Order> orders = [];
  // final List<Widget> _crosses = const [
  //   MyOrders(),
  //   // MyOrders(),
  //   // MyOrders(),
  //   // MyOrders(),
  //   // MyOrders(),
  //   // MyOrders(),
  //   // MyOrders(),
  //   // MyOrders(),
  //   // MyOrders(),
  // ];
  

Future<List<Order>> get_card() async {
  ApiService _apiService = ApiService();
  Map<String, String> headersUrl = await _apiService.headersAuthorization();
  final String baseUrl = await _apiService.baseUrl;

  List<int> order_set = [];

  final response = await http.get(
    Uri.parse('$baseUrl/product/order/'),
    headers: headersUrl,
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    
    orders.clear(); // Clear existing orders before updating
    
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
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 300),
              child: Container(
                height: 60,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.black12),
                child: Image.asset(Images.profilePhoto),
              ),
            ),
            const Text(
              'My orders',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            Expanded(
              // height: 10,
              // height: MediaQuery.of(context).size.height * 0.55,
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
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: CustomCardBaizak(
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
                              ),
                            );
                          },
                        );
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
      
      ),
    );
  }
}
