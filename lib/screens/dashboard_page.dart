import 'package:flutter/material.dart';
import '../config/colors.dart';

class UserDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          'Dashboard',
          style: TextStyle(color: AppColors.background),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome 👋",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 30),
            DashboardButton(
              icon: Icons.edit,
              title: "Write a Complaint",
              onTap: () {
                Navigator.pushNamed(context, '/write-complaint');
              },
            ),
            SizedBox(height: 20),
            DashboardButton(
              icon: Icons.track_changes,
              title: "Track Complaints",
              onTap: () {
                Navigator.pushNamed(context, '/track-complaint');
              },
            ),
            SizedBox(height: 20),
            DashboardButton(
              icon: Icons.logout,
              title: "Logout",
              onTap: () {
                // TODO: Logout logic
                Navigator.pushReplacementNamed(context, '/login-user');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const DashboardButton({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28, color: AppColors.primary),
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
