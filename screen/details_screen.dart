import 'package:flutter/material.dart';
import 'package:shopping_app/model/product_model.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final image in product.images)
                  Image.network(image, width: 200),
              ],
            ),
          ),
          Text("${product.price}"),
          SizedBox(height: 16),

          Text(product.description),
          SizedBox(height: 16),

          Row(
            children: [
              Text("${product.rating}"),
              Icon(Icons.star, color: Colors.amber),
            ],
          ),
        ],
      ),
    );
  }
}
