// lib/service_tracker_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ServiceTrackerScreen extends StatefulWidget {
  const ServiceTrackerScreen({super.key});

  @override
  State<ServiceTrackerScreen> createState() => _ServiceTrackerScreenState();
}

class _ServiceTrackerScreenState extends State<ServiceTrackerScreen> {
  final List<Map<String, dynamic>> applications = [
    {
      "service": "পাসপোর্ট রিনিউ",
      "applicationId": "PAS-2025-7841",
      "submittedOn": "১৫ জানুয়ারি ২০২৫",
      "currentStatus": "verifying",
      "steps": [
        {"title": "আবেদন জমা দেওয়া হয়েছে", "status": "completed", "date": "১৫ জানু"},
        {"title": "পেমেন্ট সম্পন্ন", "status": "completed", "date": "১৬ জানু"},
        {"title": "পুলিশ ভেরিফিকেশন", "status": "current", "date": "চলমান"},
        {"title": "প্রিন্টিং প্রক্রিয়া", "status": "pending", "date": ""},
        {"title": "ডেলিভারি", "status": "pending", "date": ""},
      ],
    },
    {
      "service": "NID নাম সংশোধন",
      "applicationId": "NID-2025-1293",
      "submittedOn": "০৫ ফেব্রুয়ারি ২০২৫",
      "currentStatus": "submitted",
      "steps": [
        {"title": "আবেদন জমা", "status": "completed", "date": "০৫ ফেব্রু"},
        {"title": "ডকুমেন্ট রিভিউ", "status": "current", "date": "চলমান"},
        {"title": "ভেরিফিকেশন", "status": "pending", "date": ""},
        {"title": "প্রিন্ট ও ডেলিভারি", "status": "pending", "date": ""},
      ],
    },
    {
      "service": "ড্রাইভিং লাইসেন্স (নতুন)",
      "applicationId": "DL-2025-0562",
      "submittedOn": "২৮ ডিসেম্বর ২০২৪",
      "currentStatus": "completed",
      "steps": [
        {"title": "আবেদন জমা", "status": "completed", "date": "২৮ ডিসে"},
        {"title": "পেমেন্ট", "status": "completed", "date": "২৯ ডিসে"},
        {"title": "পরীক্ষা পাশ", "status": "completed", "date": "১০ জানু"},
        {"title": "লাইসেন্স ইস্যু হয়েছে", "status": "completed", "date": "২০ জানু"},
      ],
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed": return Colors.green.shade600;
      case "verifying":
      case "current":   return const Color(0xFFF26422);
      case "submitted": return Colors.blue.shade700;
      default:          return Colors.grey.shade600;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "completed": return "সম্পন্ন";
      case "verifying": return "যাচাই চলছে";
      case "current":   return "চলমান";
      case "submitted": return "জমা হয়েছে";
      default:          return "অপেক্ষায়";
    }
  }

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
                  "আবেদন ট্র্যাকিং",
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
                    icon: const Icon(Icons.refresh_rounded, color: Colors.white, size: 26),
                    onPressed: () => setState(() {}),
                    tooltip: "রিফ্রেশ করুন",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          // Premium Cyan Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 70, bottom: 32),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF00ACC1), Color(0xFF00BCD4), Color(0xFF26C6DA)],
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
                  child: const Icon(Icons.timeline_rounded, size: 80, color: Colors.white),
                ),
                const SizedBox(height: 20),
                Text(
                  "আবেদনের অগ্রগতি",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Kalpurush',
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "${applications.length}টি আবেদন চলমান",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontFamily: 'Kalpurush',
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Applications List - Premium Cards
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: isTablet ? 32 : 20),
              itemCount: applications.length,
              itemBuilder: (context, index) {
                final app = applications[index];
                final statusColor = _getStatusColor(app["currentStatus"]);

                return Container(
                  margin: const EdgeInsets.only(bottom: 22),
                  child: Card(
                    elevation: 14,
                    shadowColor: statusColor.withOpacity(0.4),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                    child: Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        gradient: LinearGradient(
                          colors: [statusColor.withOpacity(0.08), Colors.white],
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
                                  color: statusColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Icon(
                                  app["currentStatus"] == "completed"
                                      ? Icons.check_circle_rounded
                                      : app["currentStatus"] == "verifying"
                                          ? Icons.hourglass_bottom_rounded
                                          : Icons.pending_rounded,
                                  color: statusColor,
                                  size: 32,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      app["service"],
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Kalpurush',
                                        color: statusColor,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "আবেদন নং: ${app["applicationId"]}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                        fontFamily: 'Kalpurush',
                                      ),
                                    ),
                                    Text(
                                      "জমা: ${app["submittedOn"]}",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black54,
                                        fontFamily: 'Kalpurush',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                  color: statusColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: statusColor.withOpacity(0.4)),
                                ),
                                child: Text(
                                  _getStatusText(app["currentStatus"]),
                                  style: TextStyle(
                                    color: statusColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: 'Kalpurush',
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Timeline Steps
                          ...List.generate(app["steps"].length, (i) {
                            final step = app["steps"][i];
                            final isCompleted = step["status"] == "completed";
                            final isCurrent = step["status"] == "current";

                            return TimelineTile(
                              alignment: TimelineAlign.start,
                              isFirst: i == 0,
                              isLast: i == app["steps"].length - 1,
                              indicatorStyle: IndicatorStyle(
                                width: 44,
                                height: 44,
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
                                    isCompleted
                                        ? Icons.check_rounded
                                        : isCurrent
                                            ? Icons.access_time_filled_rounded
                                            : Icons.radio_button_unchecked,
                                    color: Colors.white,
                                    size: isCompleted ? 26 : 20,
                                  ),
                                ),
                              ),
                              beforeLineStyle: LineStyle(
                                color: i > 0 && app["steps"][i - 1]["status"] == "completed"
                                    ? Colors.green.shade600
                                    : Colors.grey.shade400,
                                thickness: 5,
                              ),
                              endChild: Container(
                                padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      step["title"],
                                      style: TextStyle(
                                        fontSize: 15.5,
                                        fontWeight: isCurrent ? FontWeight.bold : FontWeight.w600,
                                        fontFamily: 'Kalpurush',
                                        color: isCurrent ? const Color(0xFFF26422) : Colors.black87,
                                      ),
                                    ),
                                    if (step["date"].toString().isNotEmpty)
                                      Text(
                                        step["date"],
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.black54,
                                          fontFamily: 'Kalpurush',
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ],
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