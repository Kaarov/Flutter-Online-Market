import 'package:flutter/material.dart';
import 'package:online_market/models/product_model.dart';

class FavoriteProvider extends ChangeNotifier {
  List<Product> _product = [];
  List<Product> get product => _product;
  void toggleFavorite(Product product) {
    final isExist = _product.contains(product);
    if (isExist) {
      _product.remove(product);
    } else {
      _product.add(product);
    }
    notifyListeners();
  }

  bool isExist(Product product) {
    final isExist = _product.contains(product);
    return isExist;
  }

  void ClearFavorite() {
    _product = [];
    notifyListeners();
  }
}
