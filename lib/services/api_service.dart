import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String baseUrl =
      "https://67d03bcd825945773eb017df.mockapi.io/api/v1/products"; // Đảm bảo URL đúng

  // Hàm lấy danh sách sản phẩm từ API
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      // Kiểm tra mã trạng thái HTTP
      if (response.statusCode == 200) {
        List<dynamic> data =
            jsonDecode(response.body); // Chuyển JSON thành danh sách
        return data
            .map((item) => Product.fromJson(item))
            .toList(); // Map các item thành đối tượng Product
      } else {
        throw Exception(
            'Lỗi tải dữ liệu: Mã trạng thái ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Lỗi kết nối: $e');
    }
  }
}
