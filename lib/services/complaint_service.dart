class ComplaintService {
  static final ComplaintService _instance = ComplaintService._internal();
  factory ComplaintService() => _instance;

  ComplaintService._internal();

  // List of all complaints
  List<Map<String, dynamic>> complaints = [];

  // Add a new complaint
  void addComplaint(Map<String, dynamic> complaint) {
    complaints.add(complaint);
  }

  // Get all complaints
  List<Map<String, dynamic>> get allComplaints => complaints;

  // Mark complaint as completed
  void markCompleted(String id) {
    final complaint = complaints.firstWhere((c) => c['id'] == id);
    complaint['status'] = true;
  }

  // Get completed complaints
  List<Map<String, dynamic>> get completedComplaints =>
      complaints.where((c) => c['status'] == true).toList();

  // Get pending complaints
  List<Map<String, dynamic>> get pendingComplaints =>
      complaints.where((c) => c['status'] == false).toList();
}
