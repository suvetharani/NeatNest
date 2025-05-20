import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../config/colors.dart';
import '../../services/complaint_service.dart';

class CompletionTrackerPage extends StatefulWidget {
  const CompletionTrackerPage({super.key});

  @override
  State<CompletionTrackerPage> createState() => _CompletionTrackerPageState();
}

class _CompletionTrackerPageState extends State<CompletionTrackerPage> {
  late List<Map<String, dynamic>> complaints;

  @override
  void initState() {
    super.initState();
    // Initialize complaints list
    complaints = ComplaintService().pendingComplaints;
  }

  void _refreshComplaints() {
    setState(() {
      complaints = ComplaintService().pendingComplaints;
    });
  }

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
          final isCompleted = complaint['status'] == true;

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            color: isCompleted ? AppColors.successLight : AppColors.card,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    complaint['issue'] ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isCompleted ? AppColors.success : AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    complaint['description'] ?? '',
                    style: TextStyle(color: AppColors.textLight),
                  ),
                  const SizedBox(height: 10),
                  if (complaint['mediaPath'] != null && (complaint['mediaPath'] as String).isNotEmpty)
                    buildMediaPreview(complaint['mediaPath'] as String, complaint['mediaType'] as String?),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('ID: ${complaint['id']}', style: TextStyle(color: AppColors.textLight)),
                      Switch(
                        value: isCompleted,
                        activeColor: AppColors.success,
                        inactiveTrackColor: Colors.grey.shade300,
                        onChanged: (bool value) {
  ComplaintService().markCompleted(complaint['id']);
  _refreshComplaints(); // Refresh admin's list

  if (value == true) {
    // Navigate to admin Completed Complaints
    Navigator.pushReplacementNamed(context, '/completed-complaints');

    // Simulate user update by navigating to Track Complaint page as well
    Future.delayed(const Duration(milliseconds: 300), () {
      Navigator.pushNamed(context, '/track-complaint');
    });
  }
},

                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Media preview widget function
Widget buildMediaPreview(String mediaPath, String? mediaType) {
  if (mediaPath.isEmpty) return const SizedBox.shrink();

  if (mediaType == 'image') {
    return kIsWeb
        ? const Text("Image preview not supported on Web")
        : Image.file(File(mediaPath), height: 200, width: double.infinity, fit: BoxFit.cover);
  } else if (mediaType == 'video') {
    // Placeholder for video preview
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.black12,
      child: const Center(child: Text("Video selected")),
    );
  } else {
    return const SizedBox.shrink();
  }
}
