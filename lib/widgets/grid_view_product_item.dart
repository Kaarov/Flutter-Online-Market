import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_market/models/product_model.dart';


class MyWidget extends StatelessWidget {
  const MyWidget({super.key, required this.product, required this.onSecelted});
  final Product product;
  final void Function(BuildContext context, Product product) onSecelted;

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<FavoriteProvider>(context);
    return Column(
      children: [
        InkWell(
          onTap: () {
            onSecelted(context, product);
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.grey),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                  child: Image.network(
                    product.image,
                    height: 170,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '${product.title}',
                        style: GoogleFonts.judson(
                            textStyle: const TextStyle(
                                fontSize: 24, color: Colors.black)),
                      ),
                      Row(
                        children: [
                          Text(
                            '\$${product.cost}',
                            style: GoogleFonts.judson(
                                textStyle: const TextStyle(
                                    fontSize: 24, color: Colors.black)),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                // provider.toggleFavorite(product);
                              },
                              icon: const Icon(Icons.favorite_border),

                            //   icon: provider.isExist(product)
                            //       ? const Icon(
                            //           Icons.favorite,
                            //           color: Colors.red,
                            //         )
                            //       : const Icon(
                            //           Icons.favorite,
                            //           color: Colors.white,
                            //  ), ) 
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
