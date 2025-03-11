import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> login() async {
    final String email = emailController.text;
    final String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      // Kiểm tra nếu email hoặc password trống
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')),
      );
      return;
    }

    setState(() {
      isLoading = true; // Bật loading
    });

    final response = await http.get(
      Uri.parse(
          'https://67d03bcd825945773eb017df.mockapi.io/api/v1/user'), // URL MockAPI
    );

    if (response.statusCode == 200) {
      final List<dynamic> users = json.decode(response.body);
      final user = users.firstWhere(
        (user) => user['email'] == email && user['password'] == password,
        orElse: () => null,
      );

      if (user != null) {
        // Lưu thông tin người dùng vào SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', user['id']);
        await prefs.setString('userName', user['name']);
        await prefs.setString('userEmail', user['email']);

        // Đăng nhập thành công, chuyển đến trang chính
        Navigator.pushReplacementNamed(context, '/');
      } else {
        // Tài khoản hoặc mật khẩu không đúng
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sai tài khoản hoặc mật khẩu')),
        );
      }
    } else {
      // Nếu không kết nối được MockAPI
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi kết nối đến API')),
      );
    }

    setState(() {
      isLoading = false; // Tắt loading
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Đăng Nhập")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Mật Khẩu"),
            ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator() // Hiển thị loading khi đang đăng nhập
                : ElevatedButton(
                    onPressed: login,
                    child: Text("Đăng Nhập"),
                  ),
          ],
        ),
      ),
    );
  }
}
