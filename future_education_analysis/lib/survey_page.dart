import 'package:flutter/material.dart';
import 'firebase_islemler.dart';
import 'classUniversity.dart';

class SurveyPage extends StatefulWidget {
  List<University> universities;
  SurveyPage({Key? key , required this.universities}) : super(key: key);

  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  final _formKey = GlobalKey<FormState>();
  String? _universityName;
  String? _departmentName;
  int? _satisfactionRating=0;
  int? satisfactionaboutacademicprograms;
  int? evaluationofcoursecontentandcurriculum;
  int? facultymembersandtheirteachingstyles;
  int? laboratoryandapplicationfacilities;
  int? accessingthelibraryandresources;
  int? sizeandequipmentofclassrooms;
  int? studentfacultyinteraction;
  int? academicsupportandguidanceservices;
  int? supportservicesregardinginternshipandjobfinding;
  int? thecampusandsocialfacilities;
  int? participationinstudentclubsandevents;
  int? universityadministrationandthestudent;
  int? classesandculturaldifferencesareenriching;
  int? careeropportunitiesandpostgraduationsupportservices;
  int? eventsorganizedbytheuniversity;
  int? thecafeteriafood;

    void calculateAverageAndSend() {
    int totalPoints = 0;
    int numberOfRatings = 0;

    // Boş olmayan her puanı toplama ekleyin ve sayacı artırın
    List<int?> ratings = [
      _satisfactionRating,
      satisfactionaboutacademicprograms,
      evaluationofcoursecontentandcurriculum,
      facultymembersandtheirteachingstyles,
      laboratoryandapplicationfacilities,
      accessingthelibraryandresources,
      sizeandequipmentofclassrooms,
      studentfacultyinteraction,
      academicsupportandguidanceservices,
      supportservicesregardinginternshipandjobfinding,
      thecampusandsocialfacilities,
      participationinstudentclubsandevents,
      universityadministrationandthestudent,
      classesandculturaldifferencesareenriching,
      careeropportunitiesandpostgraduationsupportservices,
      eventsorganizedbytheuniversity,
      thecafeteriafood,
    ];

    for (var rating in ratings) {
      if (rating != null) {
        totalPoints += rating;
        numberOfRatings++;
      }
    }

    if (numberOfRatings > 0) {
      // Ortalama hesaplayın ve tam sayıya dönüştürün
      int averageRating = (totalPoints / numberOfRatings).round();

      // Firestore'a gönder
      //FirestoreIslemler().setDepartment(_universityName!, _departmentName!, averageRating);
    } else {
      print("No ratings to calculate an average.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('University Evaluation Survey'),
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Wrap your Column with SingleChildScrollView
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
              Padding(
              padding: EdgeInsets.all(5),
              child: DropdownButtonFormField<String>(
                value: _universityName,
                onChanged: (newValue) {
                  setState(() {
                    _universityName = newValue!;
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
                value: _departmentName,
                onChanged: (newValue) {
                  setState(() {
                    _departmentName = newValue!;
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
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  labelText: 'Satisfaction Rating',
                ),
                items: <int>[1, 2, 3, 4, 5].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onSaved: (value) {
                  _satisfactionRating = value;
                }, onChanged: (int? value) {  },
              ),
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  labelText: 'Your satisfaction about academic programs',
                ),
                items: <int>[1, 2, 3, 4, 5].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onSaved: (value) {
                  satisfactionaboutacademicprograms = value;
                }, onChanged: (int? value) {  },
              ),
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  labelText: 'Your evaluation of course content and curriculum',
                ),
                items: <int>[1, 2, 3, 4, 5].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onSaved: (value) {
                  evaluationofcoursecontentandcurriculum = value;
                }, onChanged: (int? value) {  },
              ),
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  labelText: 'Quality of faculty members and their teaching styles',
                ),
                items: <int>[1, 2, 3, 4, 5].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onSaved: (value) {
                  facultymembersandtheirteachingstyles = value;
                }, onChanged: (int? value) {  },
              ),
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  labelText: 'Your satisfaction with laboratory and application facilities',
                ),
                items: <int>[1, 2, 3, 4, 5].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onSaved: (value) {
                  laboratoryandapplicationfacilities = value;
                }, onChanged: (int? value) {  },
              ),
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  labelText: 'Your satisfaction with accessing the library and resources',
                ),
                items: <int>[1, 2, 3, 4, 5].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onSaved: (value) {
                  accessingthelibraryandresources = value;
                }, onChanged: (int? value) {  },
              ),
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  labelText: 'Size and equipment of classrooms',
                ),
                items: <int>[1, 2, 3, 4, 5].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onSaved: (value) {
                  sizeandequipmentofclassrooms = value;
                }, onChanged: (int? value) {  },
              ),
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  labelText: 'Your satisfaction with student-faculty interaction',
                ),
                items: <int>[1, 2, 3, 4, 5].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onSaved: (value) {
                  studentfacultyinteraction = value;
                }, onChanged: (int? value) {  },
              ),
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  labelText: 'Your satisfaction with academic support and guidance services',
                ),
                items: <int>[1, 2, 3, 4, 5].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onSaved: (value) {
                  academicsupportandguidanceservices = value;
                }, onChanged: (int? value) {  },
              ),
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  labelText: 'Your satisfaction with the support services regarding internship and job finding',
                ),
                items: <int>[1, 2, 3, 4, 5].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onSaved: (value) {
                  supportservicesregardinginternshipandjobfinding = value;
                }, onChanged: (int? value) {  },
              ),
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  labelText: 'Your satisfaction with the campus and social facilities',
                ),
                items: <int>[1, 2, 3, 4, 5].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onSaved: (value) {
                  thecampusandsocialfacilities = value;
                }, onChanged: (int? value) {  },
              ),
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  labelText: 'Your satisfaction with participation in student clubs and events',
                ),
                items: <int>[1, 2, 3, 4, 5].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onSaved: (value) {
                  participationinstudentclubsandevents = value;
                }, onChanged: (int? value) {  },
              ),
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  labelText: 'Your communication satisfaction between the university administration and the student',
                ),
                items: <int>[1, 2, 3, 4, 5].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onSaved: (value) {
                  universityadministrationandthestudent = value;
                }, onChanged: (int? value) {  },
              ),
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  labelText: 'Diversity between classes and cultural differences are enriching',
                ),
                items: <int>[1, 2, 3, 4, 5].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onSaved: (value) {
                  classesandculturaldifferencesareenriching = value;
                }, onChanged: (int? value) {  },
              ),
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  labelText: 'Your satisfaction with career opportunities and post-graduation support services',
                ),
                items: <int>[1, 2, 3, 4, 5].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onSaved: (value) {
                  careeropportunitiesandpostgraduationsupportservices = value;
                }, onChanged: (int? value) {  },
              ),
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  labelText: 'Your satisfaction with the events organized by the university',
                ),
                items: <int>[1, 2, 3, 4, 5].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onSaved: (value) {
                  eventsorganizedbytheuniversity = value;
                }, onChanged: (int? value) {  },
              ),
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  labelText: 'Your satisfaction with the cafeteria food',
                ),
                items: <int>[1, 2, 3, 4, 5].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onSaved: (value) {
                  thecafeteriafood = value;
                }, onChanged: (int? value) {  },
              ),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // TODO: Anket sonuçlarını kaydet
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
