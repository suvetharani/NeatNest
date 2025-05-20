class FeedbackEntry {
  final String feedback;
  final double rating;
  final DateTime timestamp;

  FeedbackEntry({required this.feedback, required this.rating, required this.timestamp});
}

List<FeedbackEntry> feedbackList = [];
