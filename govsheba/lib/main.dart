// lib/main.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'landing_screen.dart';
import 'auth_screen.dart';
import 'app_router.dart';   // ← This imports the router we created

void main() {
  runApp(const GovShebaApp());
}

class GovShebaApp extends StatelessWidget {
  const GovShebaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'গভসেবা',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'HindSiliguri',           // ← Make sure you have this font in pubspec.yaml
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF26422),
          brightness: Brightness.light,
        ),
      ),
      routerConfig: router,   // ← This uses the GoRouter we defined in app_router.dart
    );
  }
}

// Temporary Home Screen (you can replace this later with your real dashboard)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF26422),
        title: const Text("গভসেবা ড্যাশবোর্ড", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 100, color: Color(0xFFF26422)),
            SizedBox(height: 20),
            Text(
              "সফলভাবে লগইন হয়েছে!",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text("এখন আপনি সকল সরকারি সেবা ব্যবহার করতে পারবেন"),
          ],
        ),
      ),
    );
  }
}