import 'package:flutter/material.dart';
import 'classUniversity.dart';
import 'firebase_islemler.dart';

class UniversityInformationPage extends StatefulWidget {
  final University university;
  final String department;

  const UniversityInformationPage({Key? key, required this.university, required this.department}) : super(key: key);

  @override
  _UniversityInformationPageState createState() => _UniversityInformationPageState();
}

class _UniversityInformationPageState extends State<UniversityInformationPage> {
  final _firestoreIslemler = FirestoreIslemler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.university.name,
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
              centerTitle: true,
              background: Container(
                height: 200,
                child: Image.asset(
                  "lib/assets/unilogo/${widget.university.name}.jpg",
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return const Center(
                      child: Icon(Icons.error),
                    );
                  },
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      UniversityInfoTile(title: 'Name', value: widget.university.name),
                      UniversityInfoTile(title: 'City', value: widget.university.city ?? 'Türkiye'),
                      UniversityInfoTile(title: 'Country', value: widget.university.country ?? 'unspecified'),
                      UniversityInfoTile(title: 'Founded Year', value: widget.university.foundedYear.toString()),
                      UniversityInfoTile(
                        title: 'Website',
                        value: widget.university.website ?? 'unspecified',
                        isClickable: true,
                        onTap: () {
                          // Open the website in a web browser or a WebView
                          // Implement based on your requirement
                        },
                      ),
                      UniversityInfoTile(title: 'Type', value: widget.university.type ?? 'n'),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Student Reviews',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                StreamBuilder<List<Map<String, dynamic>>>(
                  stream: _firestoreIslemler.yorumGetir(widget.university.name, widget.department),
                  builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    final yorumlar = snapshot.data!
                        .where((yorum) => yorum['universityName'] == widget.university.name)
                        .toList();

                    return Column(
                      children: yorumlar.map((yorum) {
                        return ReviewCard(
                          isStudent: yorum["isStudent"],
                          reviewText: yorum['reviewText'],
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

 // ReviewCard sınıfını buraya ekleyin
  class ReviewCard extends StatelessWidget {
    final bool isStudent;
    final String reviewText;

    const ReviewCard({
      required this.isStudent,
      required this.reviewText,
    });

    @override
    Widget build(BuildContext context) {
      return Card(
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                isStudent ? "Student" : "Non-Student",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(reviewText),
            ],
          ),
        ),
      );
    }
  }

class UniversityInfoTile extends StatelessWidget {
  final String title;
  final String? value; // Bu parametre null olabilir olduğundan, tipini nullable yapın.
  final bool isClickable;
  final VoidCallback? onTap;

  const UniversityInfoTile({
    required this.title,
    this.value, // Bu parametre artık zorunlu değil.
    this.isClickable = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Eğer value null veya boş ise, 'Unavailable' gibi bir placeholder metni göster.
    final displayValue = value?.isNotEmpty == true ? value : 'Unavailable';

    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        displayValue!,
        style: TextStyle(color: Colors.black),
      ),
      trailing: isClickable && value != null ? Icon(Icons.link, color: Colors.black) : null,
      onTap: isClickable && value != null ? onTap : null,
      contentPadding: EdgeInsets.zero,
      dense: true,
    );
  }
}
