import 'package:flutter/material.dart';
import 'package:shopping_app/data/dataset.dart';
import 'package:shopping_app/model/product_model.dart';
import 'package:shopping_app/screen/shopping_cart.dart';
import 'package:shopping_app/widgets/product_widgets.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<ProductModel> productlist = [];
  List<ProductModel> favoriteList = [];
  String selectedCategory = "All";

  @override
  void initState() {
    super.initState();
    for (final product in productsDataset) {
      productlist.add(ProductModel.fromJson(product));
    }
  }

  List<ProductModel> getFilteredProducts() {
    if (selectedCategory == "All") {
      return productlist;
    } else {
      return productlist
          .where(
            (product) =>
                product.category.toLowerCase() ==
                selectedCategory.toLowerCase(),
          )
          .toList();
    }
  }

  Widget buildCategoryItem(String category) {
    final bool isSelected = selectedCategory == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Text(
        category,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          decoration: isSelected ? TextDecoration.underline : null,
          color: isSelected ? const Color(0xff0a4b43) : Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<ProductModel> filteredProducts = getFilteredProducts();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ShoppingCart()),
          );
        },
        child: Icon(Icons.shopping_cart),
      ),
      //header
      appBar: AppBar(
        title: const Text(
          "ruw store",
          style: TextStyle(
            color: Color(0xff0a4b43),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: const Icon(Icons.person_2_outlined),
        backgroundColor: const Color(0xfff2d5d8),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Field
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(54, 242, 213, 216),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xff0a4b43)),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Color(0xff0a4b43)),
                  hintText: "Search",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Categories",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0a4b43),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildCategoryItem("All"),
                buildCategoryItem("Laptops"),
                buildCategoryItem("mobile-accessories"),
                buildCategoryItem("Smartphones"),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: filteredProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 280,
                ),
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  final isFavorite = favoriteList.contains(product);

                  return ProductWidgets(
                    products: product,
                    isFavorite: isFavorite,
                    onFavoriteTap: () {
                      setState(() {
                        if (isFavorite) {
                          favoriteList.remove(product);
                        } else {
                          favoriteList.add(product);
                        }
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
