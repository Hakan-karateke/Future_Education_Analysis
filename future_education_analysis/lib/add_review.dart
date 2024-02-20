import 'package:flutter/material.dart';
import 'classUniversity.dart';
import 'firebase_islemler.dart';

class YorumEkle extends StatefulWidget {
  final List<University> universities;

  const YorumEkle({
    Key? key,
    required this.universities,
  }) : super(key: key);

  @override
  _YorumEkleState createState() => _YorumEkleState();
}

class _YorumEkleState extends State<YorumEkle> {
  var Adi = TextEditingController();
  var Soyadi = TextEditingController();
  var kullaniciMail = TextEditingController();
  var kategori = "Bingöl Üniversitesi";
  var kategori1= "Dentist";
  var unvan = false;
  var yorum = TextEditingController();
  int? _satisfactionRating;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var ekranBilgi = MediaQuery.of(context);
    final double ekranGenislik = ekranBilgi.size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Yorum Ekle"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                controller: Adi,
                decoration: const InputDecoration(
                  hintText: "Adınız",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                controller: Soyadi,
                decoration: const InputDecoration(
                  hintText: "Soyadınız",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                controller: kullaniciMail,
                decoration: const InputDecoration(
                  hintText: "Mail Adresiniz",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: DropdownButtonFormField<String>(
                value: kategori,
                onChanged: (newValue) {
                  setState(() {
                    kategori = newValue!;
                  });
                },
                items: widget.universities.map((University university) {
                    return DropdownMenuItem<String>(
                      value: university.name,
                      child: Text(university.name),
                    );
                  }).toList(),

                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen bir üniversite seçin.';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: DropdownButtonFormField<String>(
                value: kategori1,
                onChanged: (newValue) {
                  setState(() {
                    kategori1 = newValue!;
                  });
                },
                   items: [
                'Computer engineering',
                  'Nutrition and Dietetics',
                  'Dentist',
                  'Electrical electronics Engineering',
                  'Nursing',
                  'Civil Engineering',
                  'Mechanical Engineering',
                  'Architecture',
                  'Veterinary medicine',
                  'Industrial Engineering',
                  'Mechatronic Engineering',
                  'Software engineering',
                  'Forest engineering',
                  'Healthcare Management',
                  'Business',
                  'Management information systems',
                  'History',
                  'Turkish language and literature',
                  'Social service',
                  'Maths',
                  'Economy',
                  'Philosophy',
                  'Geography',
                  'Biosystems Engineering',
                  'Biology',
                  'Pharmacy',
                  'Physical',
                  'Law',
                  'English Language and Literature',
                  'Interior architecture',
                  'Landscape Architecture',
                  'Psychology',
                  'Sociology',
                  'German language and literature',
                  'French Language and Literature',
                  'Fly',
                  'Child Development',
                  'Plant protection',
                  'Midwifery',
                  'Science teacher',
                  'Physical therapy and rehabilitation',
                  'The food Engineering',
                  'Radio, Television and Cinema',
                  'Social studies teacher',
                  'Tourism management',
                  'Turkish teacher',
                  'International relations',
                  'Classroom teaching',
                  'Pre-school teaching',
                  'Aeronautical Engineering'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen bir bölüm seçin.';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Öğrencimisiniz ?",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Checkbox(
                      value: unvan,
                      onChanged: (value) {
                        setState(() {
                          unvan = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  labelText: 'üniversiteye vereceğiniz puan',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                items: <int>[1, 2, 3, 4, 5].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onSaved: (value) {
                  _satisfactionRating = value;
                },
                onChanged: (int? value) {},
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                controller: yorum,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Lütfen Yorumunuzu Belirtiniz",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(right: ekranGenislik - 150),
              child: ElevatedButton(
                onPressed: () {
                  String fullname="${Adi.text} ${Soyadi.text}";
                  FirestoreIslemler()
                  .veriEklemeAdd(
                    universityName: kategori,
                    reviewerFullName: (fullname),
                    reviewText: yorum.text,
                    mailAdress: kullaniciMail.text,
                    score: _satisfactionRating != null ? _satisfactionRating.toString() : '0',
                    isStudent: unvan,
                    departmentName: kategori1,
                    )
                  .then((_) {
                  print('yorum basariyla eklendi.');

                yorum.clear();
                kullaniciMail.clear();
                Adi.clear();
                Soyadi.clear();

                  }).catchError((error) {
                      print('Hata oluştu: $error');
                    });

                },
                child: Text("Kaydet"),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    const Size(120, 50),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}