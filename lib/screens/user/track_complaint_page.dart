import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../config/colors.dart';
import '../../services/complaint_service.dart';

class TrackComplaintPage extends StatelessWidget {
  const TrackComplaintPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          final isCompleted = complaint['status'];

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
                  if (complaint['mediaPath'] != null && complaint['mediaPath'].isNotEmpty)
                    buildMediaPreview(complaint['mediaPath'], complaint['mediaType']),
                  const SizedBox(height: 10),
                  Text('ID: ${complaint['id']}', style: TextStyle(color: AppColors.textLight)),
                  Text('Submitted on: ${complaint['submitted']}', style: TextStyle(color: AppColors.textLight)),
                  Text(
                    'Status: ${isCompleted ? "Completed" : "Pending"}',
                    style: TextStyle(
                      color: isCompleted ? AppColors.success : Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
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

Widget buildMediaPreview(String mediaPath, String? mediaType) {
  if (mediaPath.isEmpty) return SizedBox.shrink();

  if (mediaType == 'image') {
    return kIsWeb
        ? const Text("Image preview not supported on Web")
        : Image.file(File(mediaPath), height: 200, width: double.infinity, fit: BoxFit.cover);
  } else if (mediaType == 'video') {
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
