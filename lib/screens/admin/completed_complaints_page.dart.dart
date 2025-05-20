import 'package:flutter/material.dart';
import '../../config/colors.dart';
import '../../services/complaint_service.dart';

class CompletedComplaintsPage extends StatelessWidget {
  const CompletedComplaintsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data - you can replace this with actual DB/API data
    final complaints = ComplaintService().completedComplaints;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Completed Complaints', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: AppColors.background,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: complaints.length,
        itemBuilder: (context, index) {
          final complaint = complaints[index];
          final isResolved = complaint['status'] == 'Resolved';

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            color: isResolved ? AppColors.successLight : AppColors.card,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                complaint['issue']!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isResolved ? AppColors.success : AppColors.textDark,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text('ID: ${complaint['id']}'),
                  Text('Submitted on: ${complaint['submitted']}'),
                  Text(
                    'Status: ${complaint['status']}',
                    style: TextStyle(
                      color: isResolved ? AppColors.success : Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              trailing: Icon(
                Icons.check_circle,
                color: isResolved ? AppColors.success : Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }
}
