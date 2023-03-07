import 'package:fl_productos_app/models/models.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {

  final Product product;

  const ProductCard({
    Key? key,
    required this.product
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [

            _BackgroundImage(
              imageUrl: product.picture,
            ),

            _ProductDetails(
              title: product.name,
              subtitle: product.id!,
            ),

            Positioned(
                top: 0,
                right: 0,
                child: _PriceTag(
                  price: product.price,
                )
            ),

            if(!product.available)
              const Positioned(
                top: 0,
                left: 0,
                child: _NotAvailable()
              )
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0,7),
        blurRadius: 10
      )
    ]
  );
}

class _BackgroundImage extends StatelessWidget {

  final String? imageUrl;

  const _BackgroundImage({
    Key? key,
    this.imageUrl
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: SizedBox(
        width: double.infinity,
        height: 400,
        child: imageUrl == null
          ? const Image(
              image: AssetImage('assets/images/no-image.png'),
              fit: BoxFit.cover,
          )
          : FadeInImage(
              placeholder: const AssetImage('assets/images/jar-loading.gif'),
              image: NetworkImage(imageUrl!),
              fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {

  final String title;
  final String subtitle;

  const _ProductDetails({
    Key? key,
    required this.title,
    required this.subtitle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis
            ),
            Text(
                subtitle,
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                ),
            ),

          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
    color: Colors.indigo,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), topRight: Radius.circular(25))
  );



























}

class _PriceTag extends StatelessWidget {

  final double price;

  const _PriceTag({
    Key? key,
    required this.price
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(topRight: Radius.circular(25), bottomLeft: Radius.circular(25))
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text('\$$price', style: TextStyle(color: Colors.white, fontSize: 20),)),
      ),
    );
  }
}

class _NotAvailable extends StatelessWidget {
  const _NotAvailable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.yellow[800],
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25))
      ),
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('No disponible', style: TextStyle(color: Colors.white, fontSize: 20),)),
      ),
    );
  }
}
