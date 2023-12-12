import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_market/models/product_model.dart';
import 'package:online_market/pages/product_detail.dart';
import 'package:online_market/resources/resources.dart';
import 'package:online_market/services/api_service.dart';
import 'package:online_market/widgets/grid_view_product_list.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Product> products = [];
  // Product popular = Product(
  //     id: 1,
  //     image:
  //         'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/b7d9211c-26e7-431a-ac24-b0540fb3c00f/air-force-1-07-mens-shoes-jBrhbr.png',
  //     title: 'Nike',
  //     smaltitle: 'Nike Air',
  //     description: 'Just Do It',
  //     cost: 500);

  @override
  void initState() {
    super.initState();
    fetchCard();
  }

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
      final List<dynamic> data = jsonDecode(response.body);
      products.clear();

      for (Map i in data) {
        if (!order_set.contains(i['id'])) {
          // String imageUrl = i['image'];
          // String image = "$baseUrl$imageUrl";
          Product order = Product(
            id: i['id'],
            title: i['name'],
            smaltitle: i['subname'],
            cost: i['price'],
            image: i['image'],
            description: i['description'],
          );
          products.add(order);
          order_set.add(i['id']);
        }
      }
    }
    print("Product Test");
    print(products);
    print("\n\n\n\n\n\n");
    return products;
  }

  Future<Product> get_popular() async {
    ApiService _apiService = ApiService();
    Map<String, String> headersUrl = await _apiService.headersAuthorization();
    final String baseUrl = await _apiService.baseUrl;

    final response = await http.get(
      Uri.parse('$baseUrl/product/popular/'),
      headers: headersUrl,
    );

    final Map<dynamic, dynamic> data = jsonDecode(response.body);
    

    Product popularProduct = Product(
      id: data['id'],
      title: data['name'],
      smaltitle: data['subname'],
      cost: data['price'],
      image: data['image'],
      description: data['description'],
    );

    return popularProduct;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.zero,
                    margin: const EdgeInsets.only(top: 17, right: 14),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(217, 217, 217, 217),
                        borderRadius: BorderRadius.circular(34)),
                    child: Image.asset(
                      Images.profilePhoto,
                      width: 70,
                      height: 70,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Welcome,',
                      style: GoogleFonts.judson(
                          textStyle: const TextStyle(
                              fontSize: 40, fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Our Fashion App',
                      style: GoogleFonts.judson(
                          textStyle: const TextStyle(
                              fontSize: 40, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              FutureBuilder(
                  future: get_card(),
                  builder: (context, AsyncSnapshot<List<Product>> product) {
                    if (product.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator.adaptive();
                    } else {
                      return Column(children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 20.0,
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_)=> ProductDetailsScreen(product: products.last)));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          left: 10,
                                          right: 10),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        child: Image.network(
                                          products.isNotEmpty
                                              ? products[products.length-1].image
                                              : '',
                                          width: 90,
                                          height: 90,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 17),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          products.isNotEmpty
                                              ? '${products[products.length-1].title}'
                                              : '',
                                          style: GoogleFonts.judson(
                                              textStyle: const TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w400)),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          products.isNotEmpty
                                              ? '${products[products.length-1].smaltitle}'
                                              : '',
                                          style: GoogleFonts.judson(
                                              textStyle: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey)),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          products.isNotEmpty
                                              ? '\$${products[products.length-1].cost}'
                                              : '',
                                          style: GoogleFonts.judson(
                                              textStyle: const TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w400)),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 27, top: 23, bottom: 16),
                              child: Text(
                                'All products',
                                style: GoogleFonts.judson(
                                  textStyle: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: GridViewProductList(
                            products: products,
                          ),
                        )
                      ]);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
