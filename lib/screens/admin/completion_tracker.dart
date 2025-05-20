import 'package:flutter/material.dart';
import '../../config/colors.dart';
import '../../services/complaint_service.dart';


class CompletionTrackerPage extends StatefulWidget {
  const CompletionTrackerPage({super.key});

  @override
  State<CompletionTrackerPage> createState() => _CompletionTrackerPageState();
}

class _CompletionTrackerPageState extends State<CompletionTrackerPage> {
 List<Map<String, dynamic>> complaints = ComplaintService().pendingComplaints;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          "Completion Tracker",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: complaints.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final complaint = complaints[index];
          final isCompleted = complaint['status'];

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            color: isCompleted ? AppColors.successLight : AppColors.card,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                complaint['issue'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isCompleted ? AppColors.success : AppColors.textDark,
                ),
              ),
              subtitle: Text(
                'ID: ${complaint['id']}',
                style: TextStyle(color: AppColors.textLight),
              ),
              trailing: Switch(
                value: isCompleted,
                activeColor: AppColors.success,
                inactiveTrackColor: Colors.grey.shade300,
                onChanged: (bool value) {
  setState(() {
    ComplaintService().markCompleted(complaint['id']);
  });
}

              ),
            ),
          );
        },
      ),
    );
  }
}
