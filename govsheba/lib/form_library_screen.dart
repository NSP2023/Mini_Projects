// lib/form_library_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class FormLibraryScreen extends StatefulWidget {
  const FormLibraryScreen({super.key});

  @override
  State<FormLibraryScreen> createState() => _FormLibraryScreenState();
}

class _FormLibraryScreenState extends State<FormLibraryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final Map<String, List<Map<String, dynamic>>> formCategories = {
    "পাসপোর্ট": [
      {"name": "নতুন পাসপোর্ট আবেদন ফর্ম", "url": "https://www.example.com/passport_new.pdf"},
      {"name": "পাসপোর্ট রিনিউ ফর্ম", "url": "https://www.example.com/passport_renew.pdf"},
      {"name": "হারানো পাসপোর্টের জিডি ফর্ম", "url": "https://www.example.com/passport_lost.pdf"},
    ],
    "NID সেবা": [
      {"name": "NID সংশোধন আবেদন ফর্ম", "url": "https://www.example.com/nid_correction.pdf"},
      {"name": "নতুন ভোটার নিবন্ধন ফর্ম", "url": "https://www.example.com/voter_new.pdf"},
    ],
    "জন্ম ও মৃত্যু নিবন্ধন": [
      {"name": "জন্ম নিবন্ধন ফর্ম", "url": "https://www.example.com/birth_registration.pdf"},
      {"name": "মৃত্যু নিবন্ধন ফর্ম", "url": "https://www.example.com/death_registration.pdf"},
    ],
    "ড্রাইভিং লাইসেন্স": [
      {"name": "লার্নার লাইসেন্স আবেদন", "url": "https://www.example.com/learner_license.pdf"},
      {"name": "প্রফেশনাল লাইসেন্স ফর্ম", "url": "https://www.example.com/pro_license.pdf"},
    ],
    "টিন ও ট্যাক্স": [
      {"name": "টিন নিবন্ধন ফর্ম", "url": "https://www.example.com/tin_form.pdf"},
      {"name": "আয়কর রিটার্ন ফর্ম", "url": "https://www.example.com/tax_return.pdf"},
    ],
  };

  String? selectedPdfUrl;
  String? selectedPdfTitle;

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

  void _openPdf(String url, String title) {
    setState(() {
      selectedPdfUrl = url;
      selectedPdfTitle = title;
    });
  }

  void _closePdf() {
    setState(() {
      selectedPdfUrl = null;
      selectedPdfTitle = null;
    });
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
                      border: Border.all(color: Colors.white38, width: 2),
                      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 4))],
                    ),
                    child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 24),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  "ফর্ম লাইব্রেরি",
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
                  child: const Icon(Icons.description_rounded, color: Colors.white, size: 30),
                ),
              ],
            ),
          ),
        ),
      ),

      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Stack(
          children: [
            // Main Content
            Column(
              children: [
                // Premium Header Banner
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 90, bottom: 40),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF37474F), Color(0xFF455A64), Color(0xFF607D8B)],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
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
                        child: const Icon(Icons.description_rounded, size: 90, color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "সরকারি ফর্ম লাইব্রেরি",
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Kalpurush',
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "সব ফর্ম এক জায়গায় • ডাউনলোড ছাড়াই দেখুন",
                        style: const TextStyle(color: Colors.white70, fontSize: 17, fontFamily: 'Kalpurush'),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // Form Categories - Premium Cards
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: isTablet ? 40 : 24),
                    itemCount: formCategories.keys.length,
                    itemBuilder: (context, index) {
                      final category = formCategories.keys.elementAt(index);
                      final forms = formCategories[category]!;
                      final categoryColors = [
                        const Color(0xFFF26422),
                        const Color(0xFFE91E63),
                        const Color(0xFF2196F3),
                        const Color(0xFF4CAF50),
                        const Color(0xFF9C27B0),
                      ];
                      final color = categoryColors[index % categoryColors.length];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Card(
                          elevation: 14,
                          shadowColor: color.withOpacity(0.4),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(26),
                              gradient: LinearGradient(
                                colors: [color.withOpacity(0.08), Colors.white],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: ExpansionTile(
                              leading: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: color.withOpacity(0.15),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: color.withOpacity(0.4), width: 2),
                                ),
                                child: const Icon(Icons.folder_open_rounded, color: Color(0xFFF26422), size: 28),
                              ),
                              title: Text(
                                category,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Kalpurush',
                                  color: color,
                                ),
                              ),
                              subtitle: Text(
                                "${forms.length}টি ফর্ম উপলব্ধ",
                                style: const TextStyle(fontFamily: 'Kalpurush', color: Colors.black87),
                              ),
                              collapsedBackgroundColor: Colors.transparent,
                              children: forms.map((form) => ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                leading: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(Icons.picture_as_pdf, color: Colors.red, size: 28),
                                ),
                                title: Text(
                                  form["name"],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    fontFamily: 'Kalpurush',
                                  ),
                                ),
                                trailing: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: color.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Icon(Icons.open_in_new_rounded, color: Color(0xFFF26422), size: 24),
                                ),
                                onTap: () => _openPdf(form["url"], form["name"]),
                              )).toList(),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),

            // PDF Viewer Fullscreen Overlay
            if (selectedPdfUrl != null)
              Material(
                color: Colors.black,
                child: Stack(
                  children: [
                    SfPdfViewer.network(
                      selectedPdfUrl!,
                      canShowScrollHead: false,
                      canShowPaginationDialog: false,
                      pageLayoutMode: PdfPageLayoutMode.continuous,
                    ),
                    // Top Bar with Title & Close
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black87, Colors.transparent],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: SafeArea(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: _closePdf,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    color: Colors.black54,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 24),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  selectedPdfTitle ?? "ফর্ম",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Kalpurush',
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.download_rounded, color: Colors.white),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: const Color(0xFFF26422),
                                      content: Text(
                                        "ডাউনলোড ফিচার শীঘ্রই আসছে!",
                                        style: const TextStyle(fontFamily: 'Kalpurush'),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
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