import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'landing_screen.dart';
import 'auth_screen.dart';
import 'dashboard_screen.dart';
import 'govbot_chat_screen.dart';
import 'document_organizer_screen.dart';
import 'expiry_alerts_screen.dart';
import 'service_assistant_screen.dart';
import 'service_tracker_screen.dart';
import 'tax_calculator_screen.dart';
import 'family_management_screen.dart';
import 'government_map_screen.dart';
import 'form_library_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/landing',
  routes: [
    GoRoute(path: '/landing', builder: (_, __) => const LandingScreen()),
    GoRoute(path: '/auth', builder: (_, __) => const AuthScreen()),
    GoRoute(path: '/dashboard', builder: (_, __) => const DashboardScreen()),
    GoRoute(path: '/govbot', builder: (_, __) => const GovBotChatScreen()),
    GoRoute(

  path: '/expiry',
  builder: (_, __) => const ExpiryAlertsScreen(),
),
    GoRoute(
  path: '/documents',
  builder: (_, __) => const DocumentOrganizerScreen(),
),
GoRoute(
  path: '/assistant',
  builder: (_, __) => const ServiceAssistantScreen(),
),

GoRoute(
  path: '/tax',
  builder: (_, __) => const TaxCalculatorScreen(),
),

GoRoute(
  path: '/tracker',
  builder: (_, __) => const ServiceTrackerScreen(),
), 

GoRoute(
  path: '/family',
  builder: (_, __) => const FamilyManagementScreen(),
),

GoRoute(
  path: '/map',
  builder: (_, __) => const GovernmentMapScreen(),
),


GoRoute(
  path: '/forms',
  builder: (_, __) => const FormLibraryScreen(),
),
 ],
);
