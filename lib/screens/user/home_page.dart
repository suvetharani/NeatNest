import 'package:flutter/material.dart';
import '../../config/colors.dart';

class HomePage extends StatelessWidget {
  final String role; // "User" or "Admin"

  const HomePage({required this.role, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          "NeatNest",
          style: TextStyle(color: AppColors.background),
        ),
        iconTheme: IconThemeData(color: AppColors.background),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: AppColors.primary),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    role == "Admin" ? Icons.admin_panel_settings : Icons.person,
                    size: 48,
                    color: AppColors.background,
                  ),
                  SizedBox(height: 10),
                  Text(
                    role == "Admin" ? "Admin Profile" : "User Profile",
                    style: TextStyle(color: AppColors.background, fontSize: 16),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  role == "Admin" ? "/login-admin" : "/login-user",
                );
              },
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWide = constraints.maxWidth > 600;
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: isWide
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildCards(context),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildCards(context),
                    ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildCards(BuildContext context) {
    if (role == "Admin") {
      return [
        _buildCard(context, "Completed Complaints", Icons.assignment_turned_in, "/completed-complaints"),
        SizedBox(width: 40, height: 20),
        _buildCard(context, "Completion Tracker", Icons.verified, "/completion-tracker"),
        SizedBox(width: 40, height: 20),
        _buildCard(context, "Feedback Received", Icons.feedback, "/feedback-received"),
      ];
    } else {
      return [
        _buildCard(context, "Write Complaint", Icons.edit_note, "/write-complaint"),
        SizedBox(width: 40, height: 20),
        _buildCard(context, "Track Complaint", Icons.track_changes, "/track-complaint"),
        SizedBox(width: 40, height: 20),
        _buildCard(context, "Feedback", Icons.feedback, "/feedback"),
      ];
    }
  }

  Widget _buildCard(BuildContext context, String title, IconData icon, String route) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        width: 220,
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(2, 4),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: AppColors.accent),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
