import 'package:flutter/material.dart';
import '../models/product.dart';

// Danh sách giỏ hàng toàn cục
List<Product> cart = [];

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giỏ Hàng"),
      ),
      body: cart.isEmpty
          ? Center(child: Text("Giỏ hàng trống"))
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final product = cart[index];
                return Card(
                  child: ListTile(
                    leading:
                        Image.network(product.imageUrl, width: 50, height: 50),
                    title: Text(product.name),
                    subtitle: Text("${product.price} VNĐ"),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle),
                      onPressed: () {
                        setState(() {
                          cart.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  '${product.name} đã bị xóa khỏi giỏ hàng')),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
