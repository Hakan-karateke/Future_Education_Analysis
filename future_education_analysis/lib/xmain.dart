import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'add_review.dart';
import 'classUniversity.dart';
import 'department_ranking_page.dart';
import 'survey_page.dart';
import 'university_information_page.dart'; // Bu satırı ekleyin
import 'firebaseUniversity_islemler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'University App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'University App Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<University>> futureUniversities;
  List<University>? universities;
  University? selectedUniversity;
  String? selectedDepartment;

  @override
  void initState() {
    super.initState();
    futureUniversities = fetchUniversities();
  }

  Future<List<University>> fetchUniversities() async {
    final response =
        await rootBundle.loadString('lib/assets/universities.json');
    final List<dynamic> list = jsonDecode(response);
    universities = list.map((json) => University.fromJson(json)).toList();

    for (var university in universities!) {
      await FirestoreUniversiteIslemler().verieklemeAdd(
        name: university.name,
        city: university.city ?? 'Undefined',
        country: university.country ?? 'Undefined',
        website: university.website  ?? 'Undefined',
        type: university.type ?? 'Undefined',
        foundedYear: university.foundedYear,
      );
  }
  return list.map((json) => University.fromJson(json)).toList();
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/loginimage.jpg"), // Arka plan resmi
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: FirestoreUniversiteIslemler().UniversiteGetir(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var universities = snapshot.data!;
                  return DropdownButton<dynamic>(
                    value: selectedUniversity,
                    onChanged: (newValue) {
                      setState(() {
                        selectedUniversity = newValue;
                      });
                    },
                    items: universities.map<DropdownMenuItem<dynamic>>((university) {
                      return DropdownMenuItem<dynamic>(
                        value: university,
                        child: Text(university['name']),
                      );
                    }).toList(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return CircularProgressIndicator();
              },
            ),

            DropdownButton<String>(
              value: selectedDepartment,
              onChanged: (String? newValue) {
                setState(() {
                  selectedDepartment = newValue;
                });
              },
              items: <String>[
                'Computer engineering',
                'Nutrition and Dietetics',
                'Dentist',
                'Electrical electronics Engineering',
                'Nursing'
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
                'Social service'
                    'Maths',
                'Economy',
                'Philosophy',
                'Geography',
                'Biosystems Engineering',
                'Biology',
                'Pharmacy'
                    'Physical',
                'Law',
                'English Language and Literature',
                'Interior architecture'
                    'Landscape Architecture',
                'Psychology',
                'Sociology',
                'German language and literature',
                'French Language and Literature',
                'Fly',
                'Child Development',
                'Plant protection'
                    'Midwifery'
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
                'Aeronautical Engineering'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: selectedUniversity == null
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UniversityInformationPage(
                                university: selectedUniversity!,
                                department: selectedDepartment!)),
                      );
                    },
              child: const Text('University Information'),
            ),
            ElevatedButton(
              onPressed: selectedDepartment == null
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DepartmentRankingPage(
                                department: selectedDepartment!,
                                universities: universities!)),
                      );
                    },
              child: const Text('Department Rankings'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          YorumEkle(universities: universities!)),
                );
              },
              child: const Text('Add review'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SurveyPage(universities: universities ?? [],)),
                );
              },
              child: const Text('university evaluation surveys'),
            ),
            // Diğer düğmeler burada
          ],
        ),
      )
      ),
    );
  }
}