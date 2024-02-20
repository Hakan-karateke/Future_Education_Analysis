import 'package:flutter/material.dart';
import 'classUniversity.dart';

class DepartmentRankingPage extends StatelessWidget {
  final String department;
  final List<University> universities;

  const DepartmentRankingPage({Key? key, required this.department, required this.universities}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<University> sortedUniversities = List.from(universities)
      ..sort((a, b) {
        int scoreA = getDepartmentScore(a, department);
        int scoreB = getDepartmentScore(b, department);
        return scoreB.compareTo(scoreA);
      });

    return Scaffold(
      appBar: AppBar(
        title: Text('$department Rankings'),
      ),
      body: ListView.builder(
        itemCount: sortedUniversities.length,
        itemBuilder: (context, index) {
          final university = sortedUniversities[index];
          return ListTile(
            title: Text(university.name),
            trailing: Text('Score: ${getDepartmentScore(university, department)}'),
          );
        },
      ),
    );
  }

  int getDepartmentScore(University university, String department) {
        return 0;
  }
}

