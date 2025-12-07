// lib/landing_screen.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _gradientController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 80))..repeat();
    _gradientController = AnimationController(vsync: this, duration: const Duration(seconds: 25))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _gradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final horizontalPadding = isTablet ? 80.0 : 32.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF26422),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 28),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: Stack(
        children: [
          // Animated Gradient Background
          AnimatedBuilder(
            animation: _gradientController,
            builder: (context, child) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(
                      -0.4 + _gradientController.value * 0.9,
                      -0.7 + _gradientController.value * 0.7,
                    ),
                    radius: 2.0,
                    colors: const [
                      Color(0xFFFF8A65),
                      Color(0xFFF26422),
                      Color(0xFFE64A19),
                      Color(0xFFD32F2F),
                    ],
                  ),
                ),
              );
            },
          ),

          // Floating Particles
          ...List.generate(14, (index) {
            final rand = Random(index + 100);
            final particleSize = 100 + rand.nextDouble() * 160;
            final speed = 70 + rand.nextDouble() * 50;
            final offset = rand.nextDouble() * 300 - 150;

            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final t = _controller.value * speed + index * 12;
                final opacity = (0.04 + (sin(t * 0.05) * 0.04).abs()).clamp(0.0, 1.0);

                final x = size.width / 2 + sin(t * 0.02 + index) * 180 + offset;
                final y = (t * 3.5) % (size.height + 400) - 200;

                return Positioned(
                  left: x - particleSize / 2,
                  top: y,
                  child: Opacity(
                   opacity: opacity.clamp(0.0, 1.0),

                    child: Container(
                      width: particleSize,
                      height: particleSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.2),
                            blurRadius: 90,
                            spreadRadius: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),

          // Main Scrollable Content
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                children: [
                  const SizedBox(height: 100),

                  // Logo Animation
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 3000),
                    curve: Curves.easeOutBack,
                    builder: (_, value, __) {
                      return Transform.scale(
                        scale: 0.8 + value * 0.2,
                        child: Opacity(
                          opacity: value,
                          child: Container(
                            width: isTablet ? 260 : 210,
                            height: isTablet ? 260 : 210,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(color: Colors.white54, blurRadius: 120, spreadRadius: 60),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: const Icon(Icons.account_balance, size: 120, color: Color(0xFFF26422)),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 60),

                  // App Name - Bengali
                  Text(
                    "গভসেবা",
                    style: TextStyle(
                      fontFamily: 'Kalpurush',
                      fontSize: isTablet ? 96 : 82,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 5,
                      shadows: const [
                        Shadow(color: Colors.black38, offset: Offset(3, 4), blurRadius: 10)
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 16),
                  const Text(
                    "GovSheba",
                    style: TextStyle(fontSize: 40, color: Colors.white70, letterSpacing: 14, fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 36),
                  Text(
                    "আপনার সকল সরকারি সেবা, এক অ্যাপে",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Kalpurush',
                      fontSize: 28,
                      color: Colors.white,
                      height: 1.8,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 60),

                  // Feature Cards
                  ...[
                    ("অনলাইনে আবেদন", "জন্ম নিবন্ধন, পাসপোর্ট, ভোটার আইডি – সব এক জায়গায়", Icons.description_outlined),
                    ("ফি পরিশোধ", "বিকাশ, নগদ, কার্ড দিয়ে মুহূর্তে পেমেন্ট", Icons.payment),
                    ("আবেদন ট্র্যাকিং", "আপনার আবেদনের স্ট্যাটাস রিয়েল টাইমে দেখুন", Icons.track_changes),
                    ("লাইভ সাপোর্ট", "সমস্যা হলে চ্যাটে সাপোর্টে কথা বলুন", Icons.support_agent),
                  ].map((item) => _buildFeatureCard(
                        icon: item.$3,
                        title: '${item.$1}',   // Force string to avoid inference issue
                        desc: item.$2,
                      )),

                  const SizedBox(height: 80),

                  // Login Button
                  ElevatedButton(
                    onPressed: () => context.go('/auth'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFFF26422),
                      minimumSize: const Size(double.infinity, 72),
                      elevation: 20,
                      shadowColor: Colors.black54,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
                    ),
                    child: Text(
                      "প্রবেশ করুন",
                      style: TextStyle(
                        fontFamily: 'Kalpurush',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Register Button
                  OutlinedButton(
                    onPressed: () => context.go('/auth'),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white, width: 4),
                      backgroundColor: Colors.white.withOpacity(0.18),
                      minimumSize: const Size(double.infinity, 72),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
                    ),
                    child: Text(
                      "অ্যাকাউন্ট তৈরি করুন",
                      style: TextStyle(
                        fontFamily: 'Kalpurush',
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 100),

                  // Footer Disclaimer
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      "বাংলাদেশ সরকার কর্তৃক অনুমোদিত নয় • তবে জনগণের জন্য তৈরি",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Kalpurush',
                        fontSize: 15,
                        color: Colors.white70,
                        height: 1.8,
                      ),
                    ),
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({required IconData icon, required String title, required String desc}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: Icon(icon, size: 32, color: Color(0xFFF26422)),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Kalpurush',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    desc,
                    style: TextStyle(
                      fontFamily: 'Kalpurush',
                      fontSize: 18,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}