import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: AdminHomePage(role: "Admin"),
  routes: {
    '/feedback-received': (context) => FeedbackReceivedPage(),
  },
));

class AdminHomePage extends StatelessWidget {
  final String role;
  const AdminHomePage({required this.role, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("NeatNest")),
      body: Center(
        child: Wrap(
          spacing: 20,
          children: [
            _buildCard(context, "Completed Complaints", Icons.assignment_turned_in, "/dummy"),
            _buildCard(context, "Completion Tracker", Icons.verified, "/dummy"),
            _buildCard(context, "Feedback Received", Icons.feedback, "/feedback-received"),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData icon, String route) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        width: 160,
        height: 120,
        padding: EdgeInsets.all(16),
        color: Colors.amber[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class FeedbackReceivedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Feedback")), body: Center(child: Text("Feedback Here")));
  }
}
