// lib/home_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0), // হালকা কমলা-সাদা ব্যাকগ্রাউন্ড
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "গভসেবা",
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Kalpurush',
            shadows: [
              Shadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 8,
              ),
            ],
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF26422), Color(0xFFF44336)],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () => context.go('/settings'),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(isTablet ? 32 : 20),
          child: Column(
            children: [
              // Welcome Card
              Card(
                elevation: 12,
                shadowColor: const Color(0xFFF26422).withOpacity(0.4),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.account_balance_rounded,
                        size: 80,
                        color: Color(0xFFF26422),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "স্বাগতম গভসেবায়!",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF26422),
                          fontFamily: 'Kalpurush',
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "আপনার সকল সরকারি সেবা এখন হাতের মুঠোয়\nপাসপোর্ট, NID, লাইসেন্স, ট্যাক্স — সব এক অ্যাপে",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          height: 1.6,
                          fontFamily: 'Kalpurush',
                        ),
                      ),
                      const SizedBox(height: 28),
                      ElevatedButton.icon(
                        onPressed: () => context.go('/dashboard'),
                        icon: const Icon(Icons.dashboard_rounded, size: 26),
                        label: const Text(
                          "ড্যাশবোর্ডে যান",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Kalpurush',
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF26422),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          elevation: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Quick Actions
              Text(
                "দ্রুত সেবাসমূহ",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                  fontFamily: 'Kalpurush',
                ),
              ),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: isTablet ? 3 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.4,
                children: [
                  _quickActionCard("ডকুমেন্ট সংরক্ষণ", Icons.folder_special, '/documents'),
                  _quickActionCard("মেয়াদ সতর্কতা", Icons.alarm_on, '/expiry'),
                  _quickActionCard("GovBot চ্যাট", Icons.smart_toy, '/govbot'),
                  _quickActionCard("অফিস ম্যাপ", Icons.location_on, '/map'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _quickActionCard(String title, IconData icon, String route) {
    return GestureDetector(
      onTap: () => RouteNavigator.go(route),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [Colors.orange.shade50, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: const Color(0xFFF26422).withOpacity(0.2),
                child: Icon(icon, size: 36, color: const Color(0xFFF26422)),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Kalpurush',
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ছোট হেল্পার ক্লাস — যাতে context ছাড়াই রাউট করা যায় (অপশনাল)
class RouteNavigator {
  static void go(String route, [BuildContext? context]) {
    if (context != null) {
      context.go(route);
    }
  }
}