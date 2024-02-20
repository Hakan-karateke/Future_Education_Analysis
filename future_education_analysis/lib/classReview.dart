class Review {
  String universityName;
  String reviewerFullName;
  bool isStudent;
  int score; // Score will be between 1 and 10.
  String reviewText;
  String mailAdress;
  String departmentName;

  Review({
    required this.isStudent,
    required this.universityName,
    required this.reviewerFullName,
    required this.score,
    required this.reviewText,
    required this.mailAdress,
    required this.departmentName,
  }) {
    assert(score >= 1 && score <= 10, 'Score must be between 1 and 10.');
    assert(reviewText.length <= 100, 'Review text must not exceed 100 characters.');
  }
}
