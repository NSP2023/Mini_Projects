// lib/service_assistant_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ServiceAssistantScreen extends StatefulWidget {
  const ServiceAssistantScreen({super.key});

  @override
  State<ServiceAssistantScreen> createState() => _ServiceAssistantScreenState();
}

class _ServiceAssistantScreenState extends State<ServiceAssistantScreen> {
  final List<Map<String, dynamic>> services = [
    {
      "title": "পাসপোর্ট রিনিউ",
      "icon": Icons.flight_takeoff_rounded,
      "color": Colors.indigo.shade600,
      "steps": [
        {"title": "অনলাইনে আবেদন করুন", "status": "completed"},
        {"title": "পুলিশ ভেরিফিকেশন", "status": "current"},
        {"title": "ফি জমা দিন", "status": "pending"},
        {"title": "পাসপোর্ট ডেলিভারি", "status": "pending"},
      ],
    },
    {
      "title": "NID সংশোধন",
      "icon": Icons.credit_card_rounded,
      "color": Colors.orange.shade700,
      "steps": [
        {"title": "অনলাইনে আবেদন", "status": "completed"},
        {"title": "ডকুমেন্ট জমা", "status": "completed"},
        {"title": "ভেরিফিকেশন প্রক্রিয়া", "status": "current"},
        {"title": "নতুন NID প্রিন্ট", "status": "pending"},
      ],
    },
    {
      "title": "ড্রাইভিং লাইসেন্স",
      "icon": Icons.directions_car_filled,
      "color": Colors.green.shade700,
      "steps": [
        {"title": "লার্নার আবেদন", "status": "completed"},
        {"title": "লিখিত ও ব্যবহারিক পরীক্ষা", "status": "pending"},
        {"title": "লাইসেন্স ইস্যু", "status": "pending"},
      ],
    },
    {
      "title": "জন্ম নিবন্ধন",
      "icon": Icons.child_friendly_rounded,
      "color": Colors.purple.shade600,
      "steps": [
        {"title": "অনলাইনে আবেদন করুন", "status": "pending"},
        {"title": "হাসপাতাল/ইউপি অফিসে জমা", "status": "pending"},
        {"title": "সার্টিফিকেট ইস্যু", "status": "pending"},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

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
                      border: Border.all(color: Colors.white38, width: 1.8),
                      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 4))],
                    ),
                    child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 22),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  "সার্ভিস গাইড",
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
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.smart_toy_rounded, color: Colors.white, size: 26),
                    onPressed: () => context.go('/govbot'),
                    tooltip: "GovBot এর সাহায্য নিন",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          // Premium Header Banner
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 70, bottom: 32),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF43A047), Color(0xFF66BB6A), Color(0xFF81C784)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 20, offset: Offset(0, 10))],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(colors: [Colors.white.withOpacity(0.3), Colors.transparent]),
                  ),
                  child: const Icon(Icons.menu_book_rounded, size: 80, color: Colors.white),
                ),
                const SizedBox(height: 20),
                Text(
                  "সরকারি সেবা গাইড",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Kalpurush',
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "ধাপে ধাপে সহজ নির্দেশনা • কোনো ঝামেলা ছাড়া",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15.5,
                    fontFamily: 'Kalpurush',
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Services List - Premium Cards
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: isTablet ? 32 : 20),
              itemCount: services.length,
              itemBuilder: (context, index) {
                final service = services[index];
                final color = service["color"] as Color;

                return Container(
                  margin: const EdgeInsets.only(bottom: 22),
                  child: Card(
                    elevation: 14,
                    shadowColor: color.withOpacity(0.4),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(26),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: color,
                            content: Text(
                              "${service["title"]} এর বিস্তারিত গাইড দেখানো হচ্ছে...",
                              style: const TextStyle(fontFamily: 'Kalpurush', fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          gradient: LinearGradient(
                            colors: [color.withOpacity(0.08), Colors.white],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: color.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(service["icon"], color: color, size: 34),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    service["title"],
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Kalpurush',
                                      color: color,
                                    ),
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey.shade600, size: 20),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Timeline Steps
                            ...List.generate(service["steps"].length, (i) {
                              final step = service["steps"][i];
                              final isCompleted = step["status"] == "completed";
                              final isCurrent = step["status"] == "current";

                              return TimelineTile(
                                alignment: TimelineAlign.start,
                                isFirst: i == 0,
                                isLast: i == service["steps"].length - 1,
                                indicatorStyle: IndicatorStyle(
                                  width: 42,
                                  height: 42,
                                  indicator: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isCompleted
                                          ? Colors.green.shade600
                                          : isCurrent
                                              ? const Color(0xFFF26422)
                                              : Colors.grey.shade300,
                                      border: Border.all(color: Colors.white, width: 3),
                                      boxShadow: [
                                        BoxShadow(color: Colors.black26, blurRadius: 8, offset: const Offset(0, 4)),
                                      ],
                                    ),
                                    child: Icon(
                                      isCompleted ? Icons.check_rounded : (isCurrent ? Icons.access_time : Icons.circle),
                                      color: Colors.white,
                                      size: isCompleted ? 26 : 18,
                                    ),
                                  ),
                                ),
                                beforeLineStyle: LineStyle(
                                  color: i > 0 && service["steps"][i - 1]["status"] == "completed"
                                      ? Colors.green.shade600
                                      : Colors.grey.shade400,
                                  thickness: 5,
                                ),
                                afterLineStyle: LineStyle(
                                  color: isCompleted ? Colors.green.shade600 : Colors.grey.shade400,
                                  thickness: 5,
                                ),
                                endChild: Container(
                                  padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
                                  child: Text(
                                    step["title"],
                                    style: TextStyle(
                                      fontSize: 15.5,
                                      fontWeight: isCurrent ? FontWeight.bold : FontWeight.w600,
                                      fontFamily: 'Kalpurush',
                                      color: isCurrent ? const Color(0xFFF26422) : Colors.black87,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}