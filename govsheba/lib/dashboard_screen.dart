// lib/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:badges/badges.dart' as badges;
import 'package:percent_indicator/percent_indicator.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  // Fake data
  final int totalAlerts = 5;
  final double documentProgress = 0.68;

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF26422),
        foregroundColor: Colors.white,
        title: const Text(
          "গভসেবা",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Kalpurush',
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: badges.Badge(
              badgeContent: const Text(
                '5', // will be dynamic
                style: TextStyle(color: Colors.white, fontSize: 11),
              ),
              badgeStyle: const badges.BadgeStyle(badgeColor: Colors.red),
              child: AnimatedBuilder(
                animation: _pulseController,
                builder: (_, child) => Transform.scale(
                  scale: totalAlerts > 0 ? 1.0 + _pulseController.value * 0.1 : 1.0,
                  child: IconButton(
                    icon: const Icon(Icons.notifications_active),
                    onPressed: () => context.go('/expiry'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isTablet ? 24 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome + Progress Card
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFFF26422), Color(0xFFFF7043)]),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "আসসালামু আলাইকুম",
                      style: TextStyle(fontSize: 18, color: Colors.white70, fontFamily: 'Kalpurush'),
                    ),
                    const Text(
                      "রাকিবুল হাসান",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Kalpurush'),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        CircularPercentIndicator(
                          radius: 50,
                          lineWidth: 10,
                          percent: documentProgress,
                          center: Text(
                            "${(documentProgress * 100).toInt()}%",
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          progressColor: Colors.white,
                          backgroundColor: Colors.white30,
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Text(
                            "আপনার ডকুমেন্ট ৬৮% সংরক্ষিত। বাকিগুলো আপলোড করুন।",
                            style: TextStyle(color: Colors.white, fontFamily: 'Kalpurush', fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Section Title
            Text(
              "সকল সেবা",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Kalpurush',
                  ),
            ),
            const SizedBox(height: 16),

            // Features Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: isTablet ? 3 : 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: [
                _featureCard(context, "ডকুমেন্ট সংরক্ষণ", Icons.folder_special, '/documents', Colors.orange),
                _featureCard(context, "মেয়াদ সতর্কতা", Icons.alarm_on, '/expiry', Colors.red),
                _featureCard(context, "সার্ভিস গাইড", Icons.menu_book, '/assistant', Colors.green),
                _featureCard(context, "GovBot চ্যাট", Icons.smart_toy, '/govbot', Colors.purple),
                _featureCard(context, "আবেদন ট্র্যাকিং", Icons.timeline, '/tracker', Colors.cyan),
                _featureCard(context, "ডকুমেন্ট ভেরিফাই", Icons.verified_user, '/verify', Colors.amber),
                _featureCard(context, "পরিবারের সদস্য", Icons.family_restroom, '/family', Colors.blue),
                _featureCard(context, "অফিস ম্যাপ", Icons.location_on, '/map', Colors.brown),
                _featureCard(context, "ফর্ম লাইব্রেরি", Icons.description, '/forms', Colors.grey),
                _featureCard(context, "ট্যাক্স ক্যালকুলেটর", Icons.calculate, '/tax', Colors.deepOrange),
                _featureCard(context, "অফলাইন অ্যাক্সেস", Icons.offline_pin, '/offline', Colors.teal),
                _featureCard(context, "ভাষা পরিবর্তন", Icons.language, '/settings', Colors.indigo),
              ],
            ),

            const SizedBox(height: 24),

            // Recent Alerts Title
            Text(
              "সাম্প্রতিক সতর্কতা",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Kalpurush',
                  ),
            ),
            const SizedBox(height: 12),
            _alertTile("পাসপোর্ট মেয়াদ ২৫ দিন বাকি", Icons.warning_amber, Colors.orange),
            _alertTile("NID যাচাই সফল", Icons.check_circle, Colors.green),
            _alertTile("ট্যাক্স আবেদন চলমান", Icons.pending, Colors.blue),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFF26422),
        onPressed: () => context.go('/govbot'),
        icon: const Icon(Icons.smart_toy),
        label: const Text(
          "GovBot",
          style: TextStyle(fontFamily: 'Kalpurush', fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _featureCard(BuildContext context, String title, IconData icon, String route, Color color) {
    return GestureDetector(
      onTap: () => context.go(route),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(colors: [color.withOpacity(0.2), Colors.white]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: color.withOpacity(0.2),
                child: Icon(icon, size: 36, color: color),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Kalpurush',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _alertTile(String text, IconData icon, Color color) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w600, fontFamily: 'Kalpurush'),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}