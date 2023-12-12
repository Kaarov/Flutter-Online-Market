import 'package:flutter/material.dart';
import 'package:online_market/models/product_model.dart';
import 'package:online_market/pages/product_detail.dart';
import 'package:online_market/widgets/grid_view_product_item.dart';

class GridViewProductList extends StatelessWidget {
  const GridViewProductList({super.key, required this.products});
  final List<Product> products;

  void onseletedProduct(BuildContext context, Product product) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => ProductDetailsScreen(product: product)));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          mainAxisExtent: 252),
      children: [
        for (final product in products)
          MyWidget(product: product, onSecelted: onseletedProduct),
      ],
    );
  }
}
