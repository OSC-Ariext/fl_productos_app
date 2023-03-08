import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../models/models.dart';
import 'package:http/http.dart' as http;

class ProductService extends ChangeNotifier {

  final String _baseUrl = 'flutter-varios-c3eeb-default-rtdb.firebaseio.com';

  final List<Product> products = [];

  late Product? selectedProduct;

  bool isLoading = true;
  bool isSaving = false;

  ProductService() {
    loadProducts();
  }

  Future<List<Product>> loadProducts() async {

    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json');
    final response = await http.get(url);

    final Map<String, dynamic> productMap = jsonDecode(response.body);
    
    productMap.forEach((key, value) { 
      final tempProduct = Product.fromJson(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });

    isLoading = false;
    notifyListeners();
    return products;
  }

  Future saveOrUpdateProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if(product.id == null){
      //Es necesario crear
    } else {
      // Actualizar
      await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Product product) async {

    final url = Uri.https(_baseUrl, 'products/${product.id}.json');
    final response = await http.put(url, body: product.toRawJson());
    final decodedData = response.body;

    if (kDebugMode) {
      print('response: $decodedData');
    }

    //Actualizar listado de productos
    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;

    return product.id!;


  }
}
