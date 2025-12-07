// lib/document_organizer_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DocumentOrganizerScreen extends StatefulWidget {
  const DocumentOrganizerScreen({super.key});

  @override
  State<DocumentOrganizerScreen> createState() => _DocumentOrganizerScreenState();
}

class _DocumentOrganizerScreenState extends State<DocumentOrganizerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  // Simulated document data
  final Map<String, List<Map<String, dynamic>>> categorizedDocs = {
    "পরিচয়পত্র": [
      {"name": "জাতীয় পরিচয়পত্র (NID)", "date": "আপডেট: ১৫ জানু ২০২৫", "verified": true},
      {"name": "জন্ম নিবন্ধন", "date": "আপডেট: ০২ মার্চ ২০২৪", "verified": true},
    ],
    "পাসপোর্ট ও ভিসা": [
      {"name": "পাসপোর্ট", "date": "মেয়াদ: ১০ ডিসে ২০২৬", "verified": true},
      {"name": "ভারত ভিসা", "date": "মেয়াদ: ১৫ জুলাই ২০২৫", "verified": false},
    ],
    "শিক্ষা সনদ": [
      {"name": "এসএসসি সার্টিফিকেট", "date": "২০১৮", "verified": true},
      {"name": "এইচএসসি সার্টিফিকেট", "date": "২০২০", "verified": true},
    ],
    "অন্যান্য": [
      {"name": "টিন সার্টিফিকেট", "date": "২০২৩", "verified": true},
      {"name": "ড্রাইভিং লাইসেন্স", "date": "মেয়াদ: ২০২৭", "verified": true},
    ],
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
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
                // Back Button
                GestureDetector(
                  onTap: () => context.go('/dashboard'),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.5),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 4)),
                      ],
                    ),
                    child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 22),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  "ডকুমেন্ট সংরক্ষণ",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Kalpurush',
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.shield, color: Colors.white),
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "সকল ডকুমেন্ট 256-bit এনক্রিপশনে সুরক্ষিত",
                        style: const TextStyle(fontFamily: 'Kalpurush'),
                      ),
                    ),
                  ),
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
            // Header Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Color(0xFFF26422), Color(0xFFFF7043)]),
              ),
              child: Column(
                children: [
                  const Icon(Icons.folder_special, size: 60, color: Colors.white),
                  const SizedBox(height: 12),
                  Text(
                    "আপনার সকল কাগজপত্র এক জায়গায়",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Kalpurush',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "নিরাপদ • সংগঠিত • সহজে খুঁজে পাওয়া যায়",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontFamily: 'Kalpurush',
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Upload Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "ডকুমেন্ট আপলোড ফিচার শীঘ্রই আসছে!",
                          style: const TextStyle(fontFamily: 'Kalpurush'),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.cloud_upload, size: 28),
                  label: Text(
                    "নতুন ডকুমেন্ট আপলোড করুন",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Kalpurush',
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF26422),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 10,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Categorized Folders
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: isTablet ? 32 : 16),
                itemCount: categorizedDocs.keys.length,
                itemBuilder: (context, index) {
                  final category = categorizedDocs.keys.elementAt(index);
                  final docs = categorizedDocs[category]!;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 6,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: ExpansionTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFFF26422).withOpacity(0.2),
                        child: const Icon(Icons.folder, color: Color(0xFFF26422)),
                      ),
                      title: Text(
                        category,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'Kalpurush',
                        ),
                      ),
                      subtitle: Text(
                        "${docs.length}টি ডকুমেন্ট",
                        style: const TextStyle(fontFamily: 'Kalpurush'),
                      ),
                      children: docs.map((doc) => ListTile(
                        leading: Icon(
                          doc["verified"] ? Icons.verified : Icons.schedule,
                          color: doc["verified"] ? Colors.green : Colors.orange,
                        ),
                        title: Text(
                          doc["name"],
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Kalpurush',
                          ),
                        ),
                        subtitle: Text(
                          doc["date"],
                          style: const TextStyle(fontFamily: 'Kalpurush'),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "${doc["name"]} খোলা হচ্ছে...",
                                style: const TextStyle(fontFamily: 'Kalpurush'),
                              ),
                            ),
                          );
                        },
                      )).toList(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFF26422),
        tooltip: "OCR স্ক্যান",
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "OCR দিয়ে স্ক্যান করা হচ্ছে...",
                style: const TextStyle(fontFamily: 'Kalpurush'),
              ),
            ),
          );
        },
        child: const Icon(Icons.document_scanner, color: Colors.white),
      ),
    );
  }
}