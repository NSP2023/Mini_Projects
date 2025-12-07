// lib/tax_calculator_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TaxCalculatorScreen extends StatefulWidget {
  const TaxCalculatorScreen({super.key});

  @override
  State<TaxCalculatorScreen> createState() => _TaxCalculatorScreenState();
}

class _TaxCalculatorScreenState extends State<TaxCalculatorScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  String selectedService = "পাসপোর্ট রিনিউ";
  int durationYears = 5;
  double baseFee = 5000;
  double vat = 0.0;
  double total = 5000;

  final Map<String, Map<int, double>> feeStructure = {
    "পাসপোর্ট রিনিউ": {5: 5000, 10: 7500},
    "NID সংশোধন": {1: 500},
    "জন্ম নিবন্ধন": {1: 0},
    "ড্রাইভিং লাইসেন্স": {5: 3000},
    "টিন সার্টিফিকেট": {1: 0},
  };

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

  void _calculateFee() {
    setState(() {
      baseFee = feeStructure[selectedService]![durationYears] ?? 0;
      vat = baseFee * 0.15; // 15% VAT
      total = baseFee + vat;
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
                      border: Border.all(color: Colors.white38, width: 1.8),
                      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 4))],
                    ),
                    child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 22),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  "ফি ক্যালকুলেটর",
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
                  child: const Icon(Icons.calculate_rounded, color: Colors.white, size: 28),
                ),
              ],
            ),
          ),
        ),
      ),

      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 80),
          child: Column(
            children: [
              // Premium Orange Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 40),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFFF6D00), Color(0xFFFF9800), Color(0xFFFFB74D)],
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
                      child: const Icon(Icons.calculate_rounded, size: 90, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "সরকারি ফি ক্যালকুলেটর",
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Kalpurush',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "সঠিক ফি জেনে ঝামেলা এড়ান",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontFamily: 'Kalpurush',
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Calculator Card - Premium Design
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isTablet ? 40 : 24),
                child: Card(
                  elevation: 16,
                  shadowColor: const Color(0xFFFF9800).withOpacity(0.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  child: Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: [Colors.white, const Color(0xFFFF9800).withOpacity(0.05)],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "সেবা নির্বাচন করুন",
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Kalpurush',
                            color: Color(0xFFFF6D00),
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Service Dropdown
                        DropdownButtonFormField<String>(
                          value: selectedService,
                          style: const TextStyle(fontFamily: 'Kalpurush', fontSize: 16, color: Colors.black87),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.orange.shade50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.orange.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: const Color(0xFFFF6D00), width: 2),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          ),
                          items: feeStructure.keys.map((service) {
                            return DropdownMenuItem(
                              value: service,
                              child: Text(service, style: const TextStyle(fontFamily: 'Kalpurush')),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedService = val!;
                              durationYears = feeStructure[val]!.keys.first;
                              _calculateFee();
                            });
                          },
                        ),

                        const SizedBox(height: 24),

                        // Duration Selection
                        if (selectedService == "পাসপোর্ট রিনিউ" || selectedService == "ড্রাইভিং লাইসেন্স")
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "মেয়াদ নির্বাচন করুন",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Kalpurush',
                                  color: Color(0xFFFF6D00),
                                ),
                              ),
                              const SizedBox(height: 14),
                              Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: [
                                  _durationChip("৫ বছর", 5),
                                  if (selectedService == "পাসপোর্ট রিনিউ") _durationChip("১০ বছর", 10),
                                ],
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),

                        // Fee Breakdown - Premium Box
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: const Color(0xFFF26422), width: 2),
                            boxShadow: [
                              BoxShadow(color: Colors.orange.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8)),
                            ],
                          ),
                          child: Column(
                            children: [
                              _feeRow("মূল ফি", baseFee),
                              _feeRow("ভ্যাট (১৫%)", vat),
                              const Divider(color: Color(0xFFF26422), thickness: 2, height: 32),
                              _feeRow("মোট প্রদেয়", total, isTotal: true),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Payment Buttons - Full Width & Beautiful
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isTablet ? 40 : 24),
                child: Column(
                  children: [
                    _paymentButton("বিকাশ দিয়ে পে করুন", Icons.phone_android_rounded, Colors.pink.shade600),
                    const SizedBox(height: 16),
                    _paymentButton("নগদ দিয়ে পে করুন", Icons.account_balance_wallet_rounded, Colors.orange.shade700),
                    const SizedBox(height: 16),
                    _paymentButton("কার্ড দিয়ে পে করুন", Icons.credit_card_rounded, Colors.blue.shade700),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _durationChip(String label, int years) {
    final isSelected = durationYears == years;
    return GestureDetector(
      onTap: () {
        setState(() {
          durationYears = years;
          _calculateFee();
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF26422) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: isSelected ? const Color(0xFFF26422) : Colors.transparent, width: 2),
          boxShadow: isSelected
              ? [BoxShadow(color: const Color(0xFFF26422).withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 6))]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 15,
            fontFamily: 'Kalpurush',
          ),
        ),
      ),
    );
  }

  Widget _feeRow(String title, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isTotal ? 20 : 17,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              fontFamily: 'Kalpurush',
              color: isTotal ? const Color(0xFFF26422) : Colors.black87,
            ),
          ),
          Text(
            "৳ ${amount.toStringAsFixed(0)}",
            style: TextStyle(
              fontSize: isTotal ? 28 : 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Kalpurush',
              color: isTotal ? const Color(0xFFF26422) : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentButton(String text, IconData icon, Color color) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: ElevatedButton.icon(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: color,
              content: Text(
                "$text - পেমেন্ট গেটওয়ে চালু হচ্ছে...",
                style: const TextStyle(fontFamily: 'Kalpurush', fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
        icon: Icon(icon, size: 32),
        label: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Kalpurush'),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 12,
          shadowColor: color.withOpacity(0.6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }
}