// lib/auth_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _nidController = TextEditingController();
  final _birthController = TextEditingController();
  final _contactController = TextEditingController();

  bool _isNid = true;

  final _formKey = GlobalKey<FormState>();

  // Kalpurush TextStyle
  static const TextStyle _kalpurush = TextStyle(
    fontFamily: 'Kalpurush',
    fontWeight: FontWeight.normal,
  );

  static const TextStyle _kalpurushBold = TextStyle(
    fontFamily: 'Kalpurush',
    fontWeight: FontWeight.bold,
  );

  @override
  void dispose() {
    _nidController.dispose();
    _birthController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  void _continue() {
    if (!_formKey.currentState!.validate()) return;
    context.go('/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF26422),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "স্বাগতম",
                  style: _kalpurushBold.copyWith(
                    fontSize: 44,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "আপনার পরিচয় দিন",
                  style: _kalpurush.copyWith(
                    fontSize: 22,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 50),

                // Toggle Buttons
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Expanded(child: _toggleButton("জাতীয় পরিচয়পত্র", true)),
                      Expanded(child: _toggleButton("জন্ম নিবন্ধন", false)),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // NID / Birth Registration Field
                _inputField(
                  controller: _isNid ? _nidController : _birthController,
                  hint: _isNid ? "NID নম্বর" : "জন্ম নিবন্ধন নম্বর",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "এই তথ্যটি আবশ্যক";
                    }
                    if (_isNid) {
                      if (value.length != 10 && value.length != 13 && value.length != 17) {
                        return "NID সাধারণত ১০, ১৩ অথবা ১৭ সংখ্যার হয়";
                      }
                    } else {
                      if (value.length != 17) {
                        return "জন্ম নিবন্ধন ১৭ সংখ্যার হতে হবে";
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Contact Field
                _inputField(
                  controller: _contactController,
                  hint: "মোবাইল নম্বর অথবা ইমেইল",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "মোবাইল/ইমেইল দিন";
                    }
                    if (value.contains('@')) {
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return "সঠিক ইমেইল দিন";
                      }
                    } else {
                      if (!RegExp(r'^01[3-9]\d{8}$').hasMatch(value.replaceAll(' ', ''))) {
                        return "সঠিক মোবাইল নম্বর দিন (যেমন: 01xxxxxxxxx)";
                      }
                    }
                    return null;
                  },
                ),

                const Spacer(),

                // Continue Button
                SizedBox(
                  width: double.infinity,
                  height: 64,
                  child: ElevatedButton(
                    onPressed: _continue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFFF26422),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      elevation: 8,
                    ),
                    child: Text(
                      "চালিয়ে যান",
                      style: _kalpurushBold.copyWith(
                        fontSize: 24,
                        color: const Color(0xFFF26422),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _toggleButton(String text, bool isNid) {
    final selected = _isNid == isNid;
    return GestureDetector(
      onTap: () => setState(() => _isNid = isNid),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: _kalpurush.copyWith(
            color: selected ? const Color(0xFFF26422) : Colors.white,
            fontWeight: selected ? FontWeight.bold : FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: _kalpurush.copyWith(color: Colors.white, fontSize: 18),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: _kalpurush.copyWith(color: Colors.white60),
        filled: true,
        fillColor: Colors.white.withOpacity(0.15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        errorStyle: const TextStyle(color: Colors.yellow),
      ),
      validator: validator,
    );
  }
}