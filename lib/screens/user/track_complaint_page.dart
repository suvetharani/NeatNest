import 'package:flutter/material.dart';
import '../../config/colors.dart';
import '../../models/complaint_status.dart';
//import 'package:lucide_icons/lucide_icons.dart'; // Optional if using different icons

class TrackComplaintPage extends StatelessWidget {
  TrackComplaintPage({super.key});

  final List<ComplaintStatus> statusList = [
    ComplaintStatus(
      title: "Complaint Submitted",
      time: "2025-04-10 09:15 AM",
      description: "Your complaint has been submitted successfully.",
      statusIcon: "email",
    ),
    ComplaintStatus(
      title: "Assigned to Technician",
      time: "2025-04-11 11:00 AM",
      description: "We have assigned your complaint to a technician.",
      statusIcon: "engineering",
    ),
    ComplaintStatus(
      title: "Technician on the Way",
      time: "2025-04-12 02:30 PM",
      description: "Technician is en route to your location.",
      statusIcon: "bike",
    ),
    ComplaintStatus(
      title: "Resolved",
      time: "2025-04-13 05:45 PM",
      description: "Your complaint has been resolved.",
      statusIcon: "check",
    ),
  ];

  IconData getIcon(String iconName) {
    switch (iconName) {
      case "email":
        return Icons.mark_email_read;
      case "engineering":
        return Icons.engineering;
      case "bike":
        return Icons.directions_bike;
      case "check":
        return Icons.check_circle;
      default:
        return Icons.circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Complaint Tracker", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Complaint ID: #C123456", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text("Issue: Internet not working"),
                  SizedBox(height: 4),
                  Text("Submitted On: 2025-04-10"),
                  SizedBox(height: 4),
                  Text("Status: Resolved", style: TextStyle(color: Colors.green)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Timeline (dynamic)
            ...statusList.map((status) {
              return _buildTimelineEntry(
                context,
                icon: getIcon(status.statusIcon),
                title: status.title,
                time: status.time,
                description: status.description,
              );
            }).toList(),

            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/feedback');
              },
              child: const Text(
                "Write Feedback or Rate",
                style: TextStyle(color: Color.fromARGB(255, 15, 15, 15), fontWeight: FontWeight.bold),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildTimelineEntry(BuildContext context, {
    required IconData icon,
    required String title,
    required String time,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
              child: Icon(icon, size: 20, color: Colors.white),
            ),
            Container(width: 2, height: 60, color: AppColors.primary),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(time, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                const SizedBox(height: 4),
                Text(description),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
