import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../models/models.dart';
import 'package:http/http.dart' as http;

class ProductService extends ChangeNotifier {

  final String _baseUrl = 'flutter-varios-c3eeb-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  late Product selectedProduct;

  File? newPictureFile;

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
      await createProduct(product);
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

    //Actualizar listado de productos
    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;

    return product.id!;
  }



  Future<String> createProduct(Product product) async {

    final url = Uri.https(_baseUrl, 'products.json');
    final response = await http.post(url, body: product.toRawJson());
    final decodedData = jsonDecode(response.body);

    product.id = decodedData['name'];

    products.add(product);

    return product.id!;
  }



  void updateSelectedProductImage(String path) {

    selectedProduct.picture = path;
    newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();

  }

  Future<String?> uploadImage() async {

    if(newPictureFile == null) return null;

    isSaving = true;
    notifyListeners();
    
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dgo2dapby/image/upload?upload_preset=tiaw1s8p');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamResponse);


    if(response.statusCode != 200 && response.statusCode != 201){
      print('Algo salio mal');
      print(response.body);
      return null;
    }

    newPictureFile = null;

    final decodedData = jsonDecode(response.body);
    print('debug $decodedData');
    return decodedData['secure_url'];
  }
}

