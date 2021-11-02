import 'package:flutter/material.dart';

import '../models/product.dart';

class CartItems extends ChangeNotifier {
  List<Product> products = [];
  addProduct(Product product) {
    if (!products.isEmpty) {
      for (Product p in products) {
        if (product.pid == p.pid) {
        } else {
          products.add(product);
        }
      }
    } else {
      products.add(product);
    }
    notifyListeners();
  }

  List<Product> getProducts() => products;
  void deleteProduct(String id) {
    for (Product product in products) if (product.pid == id) products.remove(product);
  }

  void clearCart() => products.clear();
}
