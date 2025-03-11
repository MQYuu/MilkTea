import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/product_detail_screen.dart';
import '../screens/cart_screen.dart'; // Import màn hình giỏ hàng

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(product.imageUrl, width: 50, height: 50),
        title: Text(product.name),
        subtitle: Text("${product.price} VNĐ"),
        trailing: IconButton(
          icon: Icon(Icons.add_shopping_cart),
          onPressed: () {
            cart.add(product); // Thêm sản phẩm vào giỏ hàng
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('${product.name} đã được thêm vào giỏ hàng')),
            );
          },
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: product),
            ),
          );
        },
      ),
    );
  }
}
