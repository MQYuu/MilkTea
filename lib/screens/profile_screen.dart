import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = 'Chưa đăng nhập';
  String userEmail = 'Chưa đăng nhập';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? 'Chưa đăng nhập';
      userEmail = prefs.getString('userEmail') ?? 'Chưa đăng nhập';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trang Cá Nhân")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (userName == 'Chưa đăng nhập') ...[
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, '/login'); // Chuyển đến trang đăng nhập
                },
                child: Text("Đăng Nhập"),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, '/register'); // Chuyển đến trang đăng ký
                },
                child: Text("Đăng Ký"),
              ),
            ] else ...[
              Text("Tên: $userName", style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Text("Email: $userEmail", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.clear(); // Đăng xuất
                  Navigator.pushReplacementNamed(
                      context, '/login'); // Quay lại trang đăng nhập
                },
                child: Text("Đăng Xuất"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
