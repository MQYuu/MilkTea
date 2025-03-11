import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/cart_screen.dart'; // Import màn hình giỏ hàng

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1; // Số lượng mặc định là 1

  void _increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decreaseQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  void _addToCart() {
    // Kiểm tra sản phẩm đã có trong giỏ hàng chưa
    bool exists = false;
    for (var item in cart) {
      if (item.id == widget.product.id) {
        exists = true;
        break;
      }
    }

    if (!exists) {
      // Thêm vào giỏ hàng nếu chưa có
      cart.add(Product(
        id: widget.product.id,
        name: widget.product.name,
        price: widget.product.price * quantity, // Cập nhật giá theo số lượng
        imageUrl: widget.product.imageUrl,
        description: widget.product.description,
      ));
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đã thêm ${widget.product.name} vào giỏ hàng')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.product.imageUrl,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Icon(Icons.error, color: Colors.red),
                );
              },
            ),
            SizedBox(height: 20),
            Text("Tên: ${widget.product.name}", style: TextStyle(fontSize: 20)),
            Text("Giá: ${widget.product.price} VNĐ",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text("Mô tả: ${widget.product.description}",
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),

            // Điều chỉnh số lượng
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: _decreaseQuantity,
                ),
                Text('$quantity', style: TextStyle(fontSize: 20)),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _increaseQuantity,
                ),
              ],
            ),

            // Nút thêm vào giỏ hàng
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addToCart,
              child: Text("Thêm vào Giỏ Hàng"),
            ),
          ],
        ),
      ),
    );
  }
}
