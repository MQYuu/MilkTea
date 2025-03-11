class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;

  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.imageUrl,
      required this.description});

  // Hàm tạo đối tượng từ JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ??
          '', // Nếu id là null, gán giá trị mặc định là chuỗi rỗng
      name: json['name'] ??
          '', // Nếu name là null, gán giá trị mặc định là chuỗi rỗng
      price: json['price'] != null
          ? double.parse(json['price'].toString())
          : 0.0, // Nếu price là null, gán giá trị mặc định là 0.0
      imageUrl: json['imageUrl'] ??
          '', // Nếu imageUrl là null, gán giá trị mặc định là chuỗi rỗng
      description: json['description'] ??
          '', // Nếu description là null, gán giá trị mặc định là chuỗi rỗng
    );
  }
}
