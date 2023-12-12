import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_market/models/product_model.dart';
import 'package:online_market/pages/home.dart';
import 'package:online_market/services/api_service.dart';
import 'package:online_market/widgets/bottom_navbar.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
        backgroundColor: Colors.white10,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              child: Image.network(
                widget.product.image,
                height: 400,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   children: [
                  Column(
                    children: [
                      Text(
                        widget.product.title,
                        style: GoogleFonts.judson(
                            textStyle: const TextStyle(fontSize: 38)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.product.smaltitle,
                        style: GoogleFonts.judson(
                          textStyle:
                              const TextStyle(fontSize: 24, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 18,
                  ),
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      width: 150,
                      height: 30,
                      decoration: BoxDecoration(
                          color: const Color(0xffD9D9D9),
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // const Text(
                          //   ,
                          //   style: TextStyle(fontSize: 15),
                          // ),
                          // const SizedBox(
                          //   width: 3,
                          // ),
                          IconButton(
                            onPressed: () {
                              _decreasing();
                            },
                            iconSize: 20,
                            icon: const Icon(Icons.remove),
                          ),
                          Text(
                            count.toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                          IconButton(
                            onPressed: () {
                              _increasing();
                            },
                            iconSize: 20,
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    'Description',
                    style: GoogleFonts.judson(
                        textStyle: const TextStyle(fontSize: 30)),
                  ),
                  Text(
                    widget.product.description,
                    style: GoogleFonts.judson(
                      textStyle:
                          const TextStyle(fontSize: 24, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Price',
                        style: GoogleFonts.judson(
                          textStyle:
                              const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '\$${widget.product.cost}',
                            style: GoogleFonts.judson(
                              textStyle: const TextStyle(fontSize: 38),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                ApiService _apiService = ApiService();

                                _apiService.posT_add_to_card(widget.product.id.toInt(), count.toInt());
                                
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const BottomNavbar()));
                              },
                              child: Text('add to card',
                                  style: GoogleFonts.judson(
                                      textStyle:
                                          const TextStyle(fontSize: 38))))
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _decreasing() {
    setState(() {
      if (count != 1) {
        count--;
      }
    });
  }

  void _increasing() {
    setState(() {
      count++;
    });
  }
}
