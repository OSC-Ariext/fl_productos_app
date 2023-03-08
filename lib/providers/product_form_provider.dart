import 'package:fl_productos_app/models/models.dart';
import 'package:flutter/material.dart';

class ProductFormProvider extends ChangeNotifier{

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //Creo una copia del producto seleccionado para modificar sus valores a partir de este
  Product product;

  ProductFormProvider(this.product);

  updateAvailability(bool value){
    print(value);
    this.product.available = value;
    notifyListeners();
  }

  bool isValidForm(){

    print(product.name);
    print(product.price);
    print(product.available);

    return formKey.currentState?.validate() ?? false;
  }



}