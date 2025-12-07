import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GovBotChatScreen extends StatefulWidget {
  const GovBotChatScreen({super.key});

  static const String routeName = '/govbot-chat';

  @override
  State<GovBotChatScreen> createState() => _GovBotChatScreenState();
}

class _GovBotChatScreenState extends State<GovBotChatScreen>
    with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;

  List<Map<String, dynamic>> messages = [
    {
      "text":
          "আসসালামু আলাইকুম! আমি গভবট\nআপনাকে পাসপোর্ট, NID, জন্ম নিবন্ধন, লাইসেন্স, ট্যাক্স — সব সরকারি কাজে সাহায্য করতে পারি।\nকী জানতে চান?",
      "isMe": false,
      "time": "এইমাত্র"
    }
  ];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    final text = _controller.text.trim();

    setState(() {
      messages.add({"text": text, "isMe": true, "time": "এইমাত্র"});
      _isTyping = true;
    });
    _controller.clear();
    _scrollToBottom();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        messages.add({
          "text": _getBotReply(text),
          "isMe": false,
          "time": "এইমাত্র"
        });
        _isTyping = false;
      });
      _scrollToBottom();
    });
  }

  String _getBotReply(String userText) {
    userText = userText.toLowerCase();
    if (userText.contains("পাসপোর্ট") || userText.contains("passport")) {
      return "পাসপোর্ট রিনিউ করতে চান?\n১. অনলাইনে আবেদন → e-Passport.gov.bd\n২. পুলিশ ভেরিফিকেশন\n৩. ফি জমা → ৫,০০০ টাকা (৫ বছর)\n৪. ডেলিভারি ৭-২১ দিনে\nচাইলে আমি পুরো প্রক্রিয়া ধাপে ধাপে দেখাতে পারি।";
    } else if (userText.contains("nid") || userText.contains("এনআইডি")) {
      return "NID সংক্রান্ত যেকোনো কাজ:\n• হারানো NID খুঁজে পাওয়া\n• জন্মতারিখ/নাম সংশোধন\n• অনলাইন কপি ডাউনলোড\n• ভোটার হয়েছেন কি না চেক\nকী করতে চান বলুন?";
    } else {
      return "দারুণ প্রশ্ন!\nআমি এখনো শিখছি। আরও বিস্তারিত বললে আরও ভালো সাহায্য করতে পারবো।\nঅথবা বলুন: পাসপোর্ট, NID, লাইসেন্স, ট্যাক্স, জন্ম নিবন্ধন ইত্যাদি।";
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFF3E0),
              Color(0xFFFFE0B2),
              Color(0xFFFFCC80),
              Color(0xFFFFAB91),
            ],
            stops: [0.0, 0.3, 0.6, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Glassmorphic AppBar
              ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      border: Border(
                        bottom: BorderSide(color: Colors.white.withOpacity(0.2), width: 1),
                      ),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => context.go('/dashboard'),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.25),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.5),
                            ),
                            child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.smart_toy, color: Color(0xFFF26422), size: 30),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "GovBot",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Kalpurush',
                                  shadows: [Shadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
                                ),
                              ),
                              Text(
                                "সর্বদা অনলাইনে",
                                style: const TextStyle(fontSize: 12, color: Colors.white70, fontFamily: 'Kalpurush'),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.info_outline_rounded, color: Colors.white),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "GovBot — আপনার ব্যক্তিগত সরকারি সহকারী",
                                  style: const TextStyle(fontFamily: 'Kalpurush'),
                                ),
                                backgroundColor: const Color(0xFFF26422),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Messages List - স্মুথ স্ক্রলিং + নো ওভারফ্লো
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                  itemCount: messages.length + (_isTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == messages.length && _isTyping) {
                      return const _TypingIndicator();
                    }
                    final msg = messages[index];
                    return _MessageBubble(
                      text: msg["text"] as String,
                      isMe: msg["isMe"] as bool,
                      time: msg["time"] as String,
                    );
                  },
                ),
              ),

              // Input Bar
              Material(
                elevation: 20,
                shadowColor: Colors.black26,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: SafeArea(
                    top: false,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            textInputAction: TextInputAction.send,
                            onSubmitted: (_) => _sendMessage(),
                            decoration: InputDecoration(
                              hintText: "আপনার প্রশ্ন লিখুন...",
                              hintStyle: TextStyle(color: Colors.grey[600], fontFamily: 'Kalpurush', fontSize: 15),
                              filled: true,
                              fillColor: const Color(0xFFFFF5E6),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                            ),
                            style: const TextStyle(fontFamily: 'Kalpurush', fontSize: 15),
                          ),
                        ),
                        const SizedBox(width: 10),
                        FloatingActionButton(
                          mini: true,
                          elevation: 6,
                          backgroundColor: const Color(0xFFF26422),
                          onPressed: _sendMessage,
                          child: const Icon(Icons.send_rounded, color: Colors.white, size: 22),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Elegant & Safe Message Bubble (Kalpurush + No Overflow)
class _MessageBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String time;

  const _MessageBubble({required this.text, required this.isMe, required this.time});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.78),
        decoration: BoxDecoration(
          gradient: isMe
              ? const LinearGradient(colors: [Color(0xFFF26422), Color(0xFFF44336)])
              : null,
          color: isMe ? null : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isMe ? 20 : 8),
            topRight: Radius.circular(isMe ? 8 : 20),
            bottomLeft: const Radius.circular(20),
            bottomRight: const Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 10, offset: const Offset(0, 5)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black87,
                fontSize: 15.5,
                height: 1.48,
                fontFamily: 'Kalpurush',
                fontWeight: FontWeight.w500,
              ),
              softWrap: true,
            ),
            const SizedBox(height: 6),
            Text(
              time,
              style: TextStyle(
                color: isMe ? Colors.white70 : Colors.grey[600],
                fontSize: 11,
                fontFamily: 'Kalpurush',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Typing Indicator
class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 14, top: 8, bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _BounceDot(delay: 0),
            _BounceDot(delay: 150),
            _BounceDot(delay: 300),
            const SizedBox(width: 12),
            Text(
              "GovBot লিখছে",
              style: const TextStyle(color: Colors.grey, fontSize: 14, fontFamily: 'Kalpurush'),
            ),
          ],
        ),
      ),
    );
  }
}

class _BounceDot extends StatefulWidget {
  final int delay;
  const _BounceDot({this.delay = 0});

  @override
  State<_BounceDot> createState() => _BounceDotState();
}

class _BounceDotState extends State<_BounceDot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))..repeat();
    if (widget.delay > 0) {
      Future.delayed(Duration(milliseconds: widget.delay), () {
        if (mounted) _controller.repeat();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        double value = _controller.value;
        double bounce = value < 0.5
            ? 4 * value * value
            : 1 - pow(1 - 2 * (value - 0.5), 3) / 4;
        return Transform.translate(
          offset: Offset(0, -12 * bounce),
          child: Container(
            width: 9,
            height: 9,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: const BoxDecoration(color: Color(0xFFF26422), shape: BoxShape.circle),
          ),
        );
      },
    );
  }
}