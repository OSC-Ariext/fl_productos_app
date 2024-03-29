import 'package:fl_productos_app/models/models.dart';
import 'package:fl_productos_app/screens/screens.dart';
import 'package:fl_productos_app/services/auth_services.dart';
import 'package:fl_productos_app/services/product_services.dart';
import 'package:fl_productos_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductService>(context);
    final authService = Provider.of<AuthServices>(context, listen: false);

    if(productService.isLoading) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        leading: IconButton(
          icon: const Icon(Icons.login_outlined),
          onPressed: (){
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ),
      body: ListView.builder(
        itemCount: productService.products.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
            onTap: () {
              productService.selectedProduct = productService.products[index].copy();
              Navigator.pushNamed(context, 'product');
            },
              child: ProductCard(
                product: productService.products[index],
              )
          )
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          productService.selectedProduct = Product(
              available: true,
              name: '',
              price: 0.0
          );
          Navigator.pushNamed(context, 'product');
        },
      ),
    );
  }
}
