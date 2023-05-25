class City {
  String? city;
  String? lat;
  String? lng;
  String? country;
  String? iso2;
  String? adminName;
  String? capital;
  String? population;
  String? populationProper;

  City({
    this.city,
    this.lat,
    this.lng,
    this.country,
    this.iso2,
    this.adminName,
    this.capital,
    this.population,
    this.populationProper,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        city: json['city'] ?? "",
        lat: json['lat'] as String?,
        lng: json['lng'] as String?,
        country: json['country'] ?? "",
        iso2: json['iso2'] as String?,
        adminName: json['admin_name'] ?? "",
        capital: json['capital'] ?? "",
        population: json['population'] as String?,
        populationProper: json['population_proper'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'city': city,
        'lat': lat,
        'lng': lng,
        'country': country,
        'iso2': iso2,
        'admin_name': adminName,
        'capital': capital,
        'population': population,
        'population_proper': populationProper,
      };
}
