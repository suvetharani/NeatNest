import 'package:flutter/material.dart';

import 'config/colors.dart';
import 'screens/login_page.dart';
import 'screens/user/home_page.dart';
import 'screens/signup_page.dart';
import 'screens/user/write_complaint_page.dart';
import 'screens/user/track_complaint_page.dart';
import 'screens/user/feedback_page.dart';
import 'screens/admin/admin_home_page.dart';
import 'screens/admin/completion_tracker.dart';
import 'screens/admin/completed_complaints_page.dart.dart';
void main() {
  runApp(NeatNestApp());
}

class NeatNestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NeatNest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.background,
          centerTitle: true,
        ),
      ),
      initialRoute: '/login-user',
      routes: {
        '/login-user': (context) => LoginPage(title: 'User Login'),
        '/login-admin': (context) => LoginPage(title: 'Admin Login'),
        '/signup': (context) => SignUpPage(),
        '/home-user': (context) => HomePage(role: "User"),
        '/home-admin': (context) => HomePage(role: "Admin"),
        '/write-complaint': (context) => WriteComplaintPage(),
        '/track-complaint': (context) => TrackComplaintPage(),
        '/feedback': (context) => const FeedbackPage(),
        //'/adminHome': (context) => const AdminHomePage(role: "Admin"),
        //'/manage-complaints': (context) => const ManageComplaintsPage(),
        '/completion-tracker': (context) => const CompletionTrackerPage(),
        '/completed-complaints': (context) => const CompletedComplaintsPage(),

      },

    );
  }
}
