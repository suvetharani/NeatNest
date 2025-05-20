class Complaint {
  final String id;
  final String issue;
  final String description;
  final String? mediaPath;
  final String submittedDate;
  bool status;

  Complaint({
    required this.id,
    required this.issue,
    required this.description,
    this.mediaPath,
    required this.submittedDate,
    this.status = false,
  });
}
