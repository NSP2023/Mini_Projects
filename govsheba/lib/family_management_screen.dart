// lib/family_management_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FamilyManagementScreen extends StatefulWidget {
  const FamilyManagementScreen({super.key});

  @override
  State<FamilyManagementScreen> createState() => _FamilyManagementScreenState();
}

class _FamilyManagementScreenState extends State<FamilyManagementScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  List<Map<String, dynamic>> familyMembers = [
    {"name": "রাকিবুল হাসান", "relation": "নিজে", "avatar": "R", "isActive": true, "color": const Color(0xFFF26422)},
    {"name": "ফাতেমা আক্তার", "relation": "স্ত্রী", "avatar": "F", "isActive": false, "color": const Color(0xFFE91E63)},
    {"name": "আরিয়ান হাসান", "relation": "ছেলে", "avatar": "A", "isActive": false, "color": const Color(0xFF2196F3)},
    {"name": "আয়েশা সিদ্দিকা", "relation": "মেয়ে", "avatar": "A", "isActive": false, "color": const Color(0xFF9C27B0)},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _switchProfile(int index) {
    setState(() {
      for (var member in familyMembers) {
        member["isActive"] = false;
      }
      familyMembers[index]["isActive"] = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: familyMembers[index]["color"],
        content: Text(
          "স্বাগতম, ${familyMembers[index]["name"]}!",
          style: const TextStyle(fontFamily: 'Kalpurush', fontWeight: FontWeight.bold, fontSize: 16),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    final activeMember = familyMembers.firstWhere((m) => m["isActive"]);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => context.go('/dashboard'),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Colors.white24, Colors.white10]),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white38, width: 2),
                      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 4))],
                    ),
                    child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 24),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  "পরিবারের সদস্য",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Kalpurush',
                    shadows: [Shadow(color: Colors.black38, offset: Offset(0, 2), blurRadius: 8)],
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(Icons.family_restroom, color: Colors.white, size: 30),
                ),
              ],
            ),
          ),
        ),
      ),

      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            // Beautiful Gradient Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 90, bottom: 40),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF2196F3), Color(0xFF21CBF3), Color(0xFF1DE9B6)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 10))],
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(colors: [Colors.white.withOpacity(0.4), Colors.transparent]),
                        ),
                      ),
                      Icon(Icons.family_restroom_rounded, size: 100, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "আপনার পরিবার, আমাদের দায়িত্ব",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Kalpurush',
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "সবার কাগজপত্র এক জায়গায় সুরক্ষিত",
                    style: const TextStyle(color: Colors.white70, fontSize: 17, fontFamily: 'Kalpurush'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Active Profile - Premium Card
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isTablet ? 40 : 24),
              child: Card(
                elevation: 16,
                shadowColor: activeMember["color"].withOpacity(0.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [Colors.white, activeMember["color"].withOpacity(0.05)],
                    ),
                  ),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 44,
                            backgroundColor: activeMember["color"],
                            child: Text(
                              activeMember["avatar"],
                              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.fromBorderSide(BorderSide(color: Colors.white, width: 3)),
                              ),
                              child: const Icon(Icons.check, size: 16, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              activeMember["name"],
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Kalpurush'),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "সক্রিয় প্রোফাইল • ${activeMember["relation"]}",
                              style: TextStyle(color: Colors.grey[700], fontSize: 15, fontFamily: 'Kalpurush'),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.favorite, color: activeMember["color"], size: 36),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Family Members List - Unique Style
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: isTablet ? 40 : 24),
                itemCount: familyMembers.length,
                itemBuilder: (context, index) {
                  final member = familyMembers[index];
                  final isActive = member["isActive"];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 18),
                    child: Card(
                      elevation: isActive ? 20 : 8,
                      shadowColor: member["color"].withOpacity(0.4),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(26),
                        onTap: () => _switchProfile(index),
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            gradient: isActive
                                ? LinearGradient(colors: [member["color"].withOpacity(0.12), Colors.white])
                                : null,
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 34,
                                backgroundColor: member["color"],
                                child: Text(
                                  member["avatar"],
                                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ),
                              const SizedBox(width: 18),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      member["name"],
                                      style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold, fontFamily: 'Kalpurush'),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      member["relation"],
                                      style: TextStyle(color: Colors.grey[600], fontSize: 15, fontFamily: 'Kalpurush'),
                                    ),
                                  ],
                                ),
                              ),
                              if (isActive)
                                const Icon(Icons.check_circle, color: Colors.green, size: 32)
                              else
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: member["color"].withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Icon(Icons.swap_horiz, color: Color(0xFFF26422), size: 26),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Add Member Button - Premium
            Padding(
              padding: EdgeInsets.all(isTablet ? 40 : 24),
              child: SizedBox(
                width: double.infinity,
                height: 68,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: const Color(0xFFF26422),
                        content: Text(
                          "নতুন সদস্য যোগ করার ফর্ম শীঘ্রই আসছে!",
                          style: const TextStyle(fontFamily: 'Kalpurush', fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.person_add_alt_1, size: 30),
                  label: Text(
                    "নতুন সদস্য যোগ করুন",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Kalpurush'),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF26422),
                    foregroundColor: Colors.white,
                    elevation: 16,
                    shadowColor: const Color(0xFFF26422).withOpacity(0.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(34)),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}