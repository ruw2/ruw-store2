import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/model/product_model.dart';
import 'package:shopping_app/providers/cart_provider.dart';
import 'package:shopping_app/screen/details_screen.dart';

class ProductWidgets extends StatelessWidget {
  final ProductModel products;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;

  const ProductWidgets({
    super.key,
    required this.products,
    required this.isFavorite,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(product: products),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(top: 8, bottom: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xfff2d5d8)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(products.images[0], width: 100, height: 100),
                Text(
                  products.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff0a4b43),
                  ),
                ),
                Text(
                  products.price.toString(),
                  style: TextStyle(color: Color(0xff0a4b43)),
                ),
                Text(
                  products.category,
                  style: TextStyle(color: Color(0xff0a4b43)),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // أضف المنتج للسلة
                            Provider.of<CartProvider>(
                              context,
                              listen: false,
                            ).addToCart(products);

                            // عرض رسالة نجاح
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'The product has been added successfully.',
                                ),
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                          child: Icon(
                            Icons.shopping_cart,
                            size: 30,
                            color: Color(0xff0a4b43),
                          ),
                        ),

                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: onFavoriteTap,
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            size: 30,
                            color:
                                isFavorite
                                    ? const Color.fromARGB(180, 244, 67, 54)
                                    : Color(0xff0a4b43),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
