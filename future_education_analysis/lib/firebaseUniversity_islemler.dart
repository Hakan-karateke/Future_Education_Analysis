import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreUniversiteIslemler {
  final CollectionReference universiteler =
      FirebaseFirestore.instance.collection('Universiteler');

  Stream<List<Map<String, dynamic>>> UniversiteGetir() {
    //department = department.replaceAll(' ', '_'); // Replace spaces with underscores

    return universiteler
        .snapshots()

        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'name': doc['name'] ?? '',
          'city': doc['city'] ?? '',
          'UniversityId': doc.id,
          'country': doc['country'] ?? '',
          'website': doc['website'] ?? '',
          'tpe': doc['type'] ?? '',
          'foundedYear': doc['foundedYear'] ?? '',
          //'department' : doc[department]
        };
      }).toList();
    });
  }

  Future<void> verieklemeAdd({
    required String name,
    required String city,
    required String country,
    required String website,
    required String type,
    required String foundedYear
  }) async {
    Map<String, dynamic> _addUniversity = {
      'name': name,
      'city': city,
      'country': country,
      'website': website,
      'type': type,
      'foundedYear': foundedYear,
    };

    await universiteler.add(_addUniversity);
  }
}