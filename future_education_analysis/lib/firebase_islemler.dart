import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreIslemler {
  final CollectionReference yorumlar =
      FirebaseFirestore.instance.collection('Yorumlar');

  Stream<List<Map<String, dynamic>>> yorumGetir(String a, String b) {
    return yorumlar
        .where('universityName', isEqualTo: a).where('departmentName', isEqualTo: b)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'isStudent': doc['isStudent'] ?? '',
          'departmentName': doc['departmentName'] ?? '',
          'reviewId': doc.id,
          'universityName': doc['universityName'] ?? '',
          'reviewerFullName': doc['reviewerFullName'] ?? '',
          'reviewText': doc['reviewText'] ?? '',
          'mailAdress': doc['mailAdress'] ?? '',
          'score': doc['score'] ?? 0,
        };
      }).toList();
    });
  }

  Future<void> veriEklemeAdd({
    required String universityName,
    required String reviewerFullName,
    required String reviewText,
    required String mailAdress,
    required String score,
    required bool isStudent,
    required String departmentName
  }) async {
    Map<String, dynamic> _addReview = {
      'universityName': universityName,
      'reviewerFullName': reviewerFullName,
      'reviewText': reviewText,
      'mailAdress': mailAdress,
      'score': int.parse(score),
      'isStudent': isStudent,
      'departmentName': departmentName,
    };

    await yorumlar.add(_addReview);
  }
}