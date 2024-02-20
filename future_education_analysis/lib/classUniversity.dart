class University {
  String name;
  String? city;
  String? country;
  String? type;
  String foundedYear;
  String? website;


  University({
    required this.name,
    required this.city,
    required this.foundedYear,
    required this.website,
    required this.type,
    required this.country,
  });

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      name: json['Adı'] ?? '',
      city: json['İli'] ?? '',
      country: 'Türkiye',
      type: json['Türü'] ?? '',
      foundedYear: json['Kuruluşu'] ?? '',
      website: json['İnternet Sitesi'] ?? '',
    );
  }
}