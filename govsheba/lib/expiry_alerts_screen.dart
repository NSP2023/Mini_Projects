// lib/expiry_alerts_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExpiryAlertsScreen extends StatefulWidget {
  const ExpiryAlertsScreen({super.key});

  @override
  State<ExpiryAlertsScreen> createState() => _ExpiryAlertsScreenState();
}

class _ExpiryAlertsScreenState extends State<ExpiryAlertsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> expiringDocs = [
    {"name": "পাসপোর্ট", "expiry": DateTime(2025, 12, 10), "daysLeft": 25, "type": "critical"},
    {"name": "ভারত ভিসা", "expiry": DateTime(2025, 7, 15), "daysLeft": 60, "type": "warning"},
    {"name": "ড্রাইভিং লাইসেন্স", "expiry": DateTime(2026, 3, 20), "daysLeft": 180, "type": "info"},
    {"name": "টিন সার্টিফিকেট", "expiry": DateTime(2025, 11, 1), "daysLeft": 45, "type": "critical"},
  ];

  bool pushNotification = true;
  bool inAppNotification = true;
  int notifyBeforeDays = 30;

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

  Color _getColor(String type) {
    switch (type) {
      case "critical": return const Color(0xFFE91E63);
      case "warning": return const Color(0xFFFF6D00);
      default: return const Color(0xFF2196F3);
    }
  }

  IconData _getIcon(String type) {
    switch (type) {
      case "critical": return Icons.error;
      case "warning": return Icons.warning_amber;
      default: return Icons.info_outline;
    }
  }

  String _getPriorityText(int days) {
    if (days <= 30) return "জরুরি!";
    if (days <= 90) return "শীঘ্রই";
    return "পরে";
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => context.go('/dashboard'),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Colors.white24, Colors.white10]),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white38, width: 1.5),
                      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 4))],
                    ),
                    child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 22),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  "মেয়াদোত্তীর্ণ সতর্কতা",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Kalpurush',
                    shadows: [Shadow(color: Colors.black38, offset: Offset(0, 2), blurRadius: 8)],
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(Icons.notifications_active, color: Colors.white, size: 28),
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
            // Premium Gradient Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 80, bottom: 32, left: 24, right: 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFE91E63), Color(0xFFF44336), Color(0xFFD32F2F)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 10))],
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(colors: [Colors.white.withOpacity(0.3), Colors.transparent]),
                        ),
                      ),
                      const Icon(Icons.alarm_on_rounded, size: 80, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "আপনার কাগজপত্রের মেয়াদ শেষ হচ্ছে!",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Kalpurush',
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${expiringDocs.length}টি ডকুমেন্টের মেয়াদ শীঘ্রই শেষ",
                    style: const TextStyle(color: Colors.white70, fontSize: 17, fontFamily: 'Kalpurush'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Notification Settings Card (Beautiful)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isTablet ? 32 : 20),
              child: Card(
                elevation: 12,
                shadowColor: Colors.pink.withOpacity(0.3),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.pink.withOpacity(0.03)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.settings_suggest, color: Color(0xFFE91E63)),
                          const SizedBox(width: 12),
                          Text(
                            "নোটিফিকেশন সেটিংস",
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Kalpurush'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildSwitchTile("পুশ নোটিফিকেশন", "অ্যাপ বন্ধ থাকলেও সতর্কতা পাবেন", pushNotification, (v) => setState(() => pushNotification = v)),
                      _buildSwitchTile("ইন-অ্যাপ নোটিফিকেশন", "অ্যাপ খোলা থাকলে বেল আইকন দেখাবে", inAppNotification, (v) => setState(() => inAppNotification = v)),
                      ListTile(
                        leading: const Icon(Icons.calendar_today, color: Color(0xFFE91E63)),
                        title: Text("কত দিন আগে সতর্ক করবে?", style: const TextStyle(fontFamily: 'Kalpurush', fontWeight: FontWeight.w600)),
                        trailing: DropdownButton<int>(
                          value: notifyBeforeDays,
                          style: const TextStyle(fontFamily: 'Kalpurush', color: Colors.black87),
                          items: [7, 15, 30, 60, 90].map((days) => DropdownMenuItem(
                            value: days,
                            child: Text("$days দিন", style: const TextStyle(fontFamily: 'Kalpurush')),
                          )).toList(),
                          onChanged: (val) => setState(() => notifyBeforeDays = val!),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Expiring Documents – Unique Card Style
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: isTablet ? 32 : 20),
                itemCount: expiringDocs.length,
                itemBuilder: (context, index) {
                  final doc = expiringDocs[index];
                  final color = _getColor(doc["type"]);
                  final priority = _getPriorityText(doc["daysLeft"]);

                  return Container(
                    margin: const EdgeInsets.only(bottom: 18),
                    child: Card(
                      elevation: 10,
                      shadowColor: color.withOpacity(0.4),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: LinearGradient(
                            colors: [color.withOpacity(0.08), Colors.white],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          leading: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.15),
                              shape: BoxShape.circle,
                              border: Border.all(color: color.withOpacity(0.3), width: 2),
                            ),
                            child: Icon(_getIcon(doc["type"]), color: color, size: 30),
                          ),
                          title: Text(
                            doc["name"],
                            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold, fontFamily: 'Kalpurush'),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                "মেয়াদ শেষ: ${doc["expiry"].toString().substring(0, 10)}",
                                style: const TextStyle(fontFamily: 'Kalpurush', color: Colors.black87),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "→ $priority রিনিউ করুন",
                                style: TextStyle(color: color, fontWeight: FontWeight.bold, fontFamily: 'Kalpurush'),
                              ),
                            ],
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: color.withOpacity(0.4)),
                            ),
                            child: Text(
                              "${doc["daysLeft"]} দিন",
                              style: TextStyle(color: color, fontWeight: FontWeight.bold, fontFamily: 'Kalpurush', fontSize: 16),
                            ),
                          ),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: color,
                                content: Text("${doc["name"]} রিনিউ করার গাইড দেখুন", style: const TextStyle(fontFamily: 'Kalpurush', fontWeight: FontWeight.bold)),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(fontFamily: 'Kalpurush', fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(fontFamily: 'Kalpurush', fontSize: 13, color: Colors.black54)),
      value: value,
      activeColor: const Color(0xFFE91E63),
      activeTrackColor: const Color(0xFFE91E63).withOpacity(0.4),
      onChanged: onChanged,
    );
  }
}