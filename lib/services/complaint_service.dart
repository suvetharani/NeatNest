class ComplaintService {
  static final ComplaintService _instance = ComplaintService._internal();
  factory ComplaintService() => _instance;

  ComplaintService._internal();

  // List of all complaints
  final List<Map<String, dynamic>> _complaints = [];

  // Add a new complaint
void addComplaint(Map<String, dynamic> complaint) {
  _complaints.add({
    'id': complaint['id'],
    'issue': complaint['issue'],
    'description': complaint['description'],
    'mediaPath': complaint['mediaPath'],
    'mediaType': complaint['mediaType'],  // Add this line
    'submitted': complaint['submitted'],
    'status': complaint['status'] ?? false,
  });
}


  // Get all complaints
  List<Map<String, dynamic>> get allComplaints => _complaints;

  // Mark complaint as completed
  void markCompleted(String id) {
    final complaint = _complaints.firstWhere((c) => c['id'] == id);
    complaint['status'] = true;
  }

  // Get completed complaints
  List<Map<String, dynamic>> get completedComplaints =>
      _complaints.where((c) => c['status'] == true).toList();

  // Get pending complaints
  List<Map<String, dynamic>> get pendingComplaints =>
      _complaints.where((c) => c['status'] == false).toList();
}
