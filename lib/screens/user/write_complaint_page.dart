import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../config/colors.dart';
import '../../services/complaint_service.dart';


class WriteComplaintPage extends StatefulWidget {
  const WriteComplaintPage({super.key});

  @override
  State<WriteComplaintPage> createState() => _WriteComplaintPageState();
}

class _WriteComplaintPageState extends State<WriteComplaintPage> {
  TextEditingController issueController = TextEditingController();

  final TextEditingController _complaintController = TextEditingController();
  File? _mediaFile;
  String? _mediaType;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickMedia(ImageSource source, bool isVideo) async {
    final pickedFile = isVideo
        ? await _picker.pickVideo(source: source)
        : await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _mediaFile = File(pickedFile.path);
        _mediaType = isVideo ? "video" : "image";
      });
    }
  }

  void _submitComplaint() {
  final complaint = {
    'id': '#C${DateTime.now().millisecondsSinceEpoch}',
    'issue': issueController.text.trim(),
    'description': _complaintController.text.trim(),
    'mediaPath': _mediaFile?.path,
    'submitted': DateTime.now().toString().split(" ")[0],
    'status': false,
  };

  ComplaintService().addComplaint(complaint);

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Complaint submitted!")),
  );

  Navigator.pop(context);
}



  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 600;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Write Complaint", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: isWide ? 500 : double.infinity),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _complaintController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: "Describe your complaint...",
                        filled: true,
                        fillColor: AppColors.card,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    if (_mediaFile != null)
                      _mediaType == "image"
                          ? kIsWeb
                              ? const Text("Image preview not available in web mode.")
                              : Image.file(_mediaFile!, height: 200)
                          : Container(
                              height: 200,
                              color: Colors.black12,
                              child: const Center(child: Text("Video Selected")),
                            ),

                    const SizedBox(height: 20),

                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => _pickMedia(ImageSource.gallery, false),
                          icon: const Icon(Icons.image),
                          label: const Text("Add Image"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accent,
                            foregroundColor: Colors.white,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => _pickMedia(ImageSource.gallery, true),
                          icon: const Icon(Icons.videocam),
                          label: const Text("Add Video"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accent,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    ElevatedButton(
                      onPressed: _submitComplaint,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Submit", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
