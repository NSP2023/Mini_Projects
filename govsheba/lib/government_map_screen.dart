// lib/government_map_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GovernmentMapScreen extends StatefulWidget {
  const GovernmentMapScreen({super.key});

  @override
  State<GovernmentMapScreen> createState() => _GovernmentMapScreenState();
}

class _GovernmentMapScreenState extends State<GovernmentMapScreen> {
  static const LatLng _dhakaCenter = LatLng(23.8103, 90.4125);
  late final ScrollController _bottomScrollController = ScrollController();

  final Set<Marker> _markers = {
    Marker(
      markerId: const MarkerId("passport_office"),
      position: const LatLng(23.7332, 90.3987),
      infoWindow: const InfoWindow(
        title: "পাসপোর্ট অফিস আগারগাঁও",
        snippet: "ঢাকা • নতুন ও রিনিউ",
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ),
    Marker(
      markerId: const MarkerId("brta"),
      position: const LatLng(23.7542, 90.3753),
      infoWindow: const InfoWindow(
        title: "BRTA মিরপুর",
        snippet: "ড্রাইভিং লাইসেন্স ও গাড়ি রেজিস্ট্রেশন",
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ),
    Marker(
      markerId: const MarkerId("dc_office"),
      position: const LatLng(23.7263, 90.4216),
      infoWindow: const InfoWindow(
        title: "ঢাকা জেলা প্রশাসকের কার্যালয়",
        snippet: "সেগুনবাগিচা • সকল সেবা",
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ),
  };

  @override
  void dispose() {
    _bottomScrollController.dispose();
    super.dispose();
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
                // Back Button
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
                  "সরকারি অফিস ম্যাপ",
                  style: const TextStyle(
                    fontSize: 21,
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
                  child: const Icon(Icons.my_location_rounded, color: Colors.white, size: 26),
                ),
              ],
            ),
          ),
        ),
      ),

      body: Stack(
        children: [
          // Google Map Fullscreen
          GoogleMap(
            initialCameraPosition: const CameraPosition(target: _dhakaCenter, zoom: 11.8),
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
          ),

          // Top Gradient Banner
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 70, bottom: 32),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF6D4C41), Color(0xFF5D4037), Color(0xFF4E342E)],
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
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(colors: [Colors.white.withOpacity(0.3), Colors.transparent]),
                  ),
                  child: const Icon(Icons.location_city_rounded, size: 80, color: Colors.white),
                ),
                const SizedBox(height: 16),
                Text(
                  "নিকটস্থ সরকারি অফিস",
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Kalpurush',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "পাসপোর্ট, NID, BRTA, DC অফিস — সব এক ক্লিকে",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    fontFamily: 'Kalpurush',
                  ),
                ),
              ],
            ),
          ),

          // Search Bar (Fixed & Safe)
          Positioned(
            top: MediaQuery.of(context).padding.top + 180,
            left: 20,
            right: 20,
            child: Card(
              elevation: 12,
              shadowColor: Colors.black38,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
              child: TextField(
                style: const TextStyle(fontFamily: 'Kalpurush', fontSize: 15),
                decoration: InputDecoration(
                  hintText: "অফিস বা সেবার নাম লিখুন...",
                  hintStyle: const TextStyle(fontFamily: 'Kalpurush', fontSize: 15, color: Colors.grey),
                  prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFFF26422), size: 26),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
                onSubmitted: (value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: const Color(0xFFF26422),
                      content: Text("খুঁজছি: $value", style: const TextStyle(fontFamily: 'Kalpurush')),
                    ),
                  );
                },
              ),
            ),
          ),

          // Bottom Scrollable Office Cards
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: SizedBox(
              height: 160,
              child: ListView(
                controller: _bottomScrollController,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: [
                  _officeCard(
                    title: "পাসপোর্ট অফিস",
                    subtitle: "আগারগাঁও, ঢাকা",
                    distance: "২.৫ কিমি দূরে",
                    icon: Icons.flight_takeoff_rounded,
                    color: Colors.red,
                  ),
                  _officeCard(
                    title: "BRTA মিরপুর",
                    subtitle: "ড্রাইভিং লাইসেন্স",
                    distance: "৪.১ কিমি দূরে",
                    icon: Icons.directions_car_filled,
                    color: Colors.blue,
                  ),
                  _officeCard(
                    title: "DC অফিস",
                    subtitle: "সেগুনবাগিচা",
                    distance: "৬.৮ কিমি দূরে",
                    icon: Icons.account_balance_rounded,
                    color: Colors.green.shade700,
                  ),
                  _officeCard(
                    title: "ইউনিয়ন পরিষদ",
                    subtitle: "নিকটস্থ ইউপি",
                    distance: "১.২ কিমি দূরে",
                    icon: Icons.location_on_rounded,
                    color: Colors.purple,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _officeCard({
    required String title,
    required String subtitle,
    required String distance,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 18),
      child: Card(
        elevation: 14,
        shadowColor: color.withOpacity(0.4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.12), Colors.white],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(icon, color: color, size: 32),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Kalpurush',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 13.5,
                            color: Colors.black87,
                            fontFamily: 'Kalpurush',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(Icons.directions_rounded, size: 20, color: color),
                  const SizedBox(width: 6),
                  Text(
                    distance,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'Kalpurush',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}