class User {
  User({
    required this.name,
    required this.images,
    required this.gender,
    required this.species,
    required this.homePlanet,
    required this.occupation,
    required this.sayings,
    required this.id,
    required this.age,
  });

  final Name name;
  final Images images;
  final String gender;
  final String species;
  final String homePlanet;
  final String occupation;
  final List<String> sayings;
  final int id;
  final String age;

  User copyWith({
    Name? name,
    Images? images,
    String? gender,
    String? species,
    String? homePlanet,
    String? occupation,
    List<String>? sayings,
    int? id,
    String? age,
  }) =>
      User(
        name: name ?? this.name,
        images: images ?? this.images,
        gender: gender ?? this.gender,
        species: species ?? this.species,
        homePlanet: homePlanet ?? this.homePlanet,
        occupation: occupation ?? this.occupation,
        sayings: sayings ?? this.sayings,
        id: id ?? this.id,
        age: age ?? this.age,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: Name.fromJson(json["name"]),
        images: Images.fromJson(json["images"]),
        gender: json["gender"],
        species: json["species"],
        homePlanet: json["homePlanet"] ?? "Unknown",
        occupation: json["occupation"] ?? "Unknown",
        sayings: List<String>.from(json["sayings"].map((x) => x)),
        id: json["id"],
        age: json["age"],
      );

  Map<String, dynamic> toJson() => {
        "name": name.toJson(),
        "images": images.toJson(),
        "gender": gender,
        "species": species,
        "homePlanet": homePlanet,
        "occupation": occupation,
        "sayings": List<dynamic>.from(sayings.map((x) => x)),
        "id": id,
        "age": age,
      };
}

class Images {
  Images({
    required this.headShot,
    required this.main,
  });

  final String headShot;
  final String main;

  Images copyWith({
    String? headShot,
    String? main,
  }) =>
      Images(
        headShot: headShot ?? this.headShot,
        main: main ?? this.main,
      );

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        headShot: json["head-shot"],
        main: json["main"],
      );

  Map<String, dynamic> toJson() => {
        "head-shot": headShot,
        "main": main,
      };
}

class Name {
  Name({
    required this.first,
    required this.middle,
    required this.last,
  });

  final String first;
  final String middle;
  final String last;

  String get fullName => "$first $middle $last";

  Name copyWith({
    String? first,
    String? middle,
    String? last,
  }) =>
      Name(
        first: first ?? this.first,
        middle: middle ?? this.middle,
        last: last ?? this.last,
      );

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        first: json["first"],
        middle: json["middle"],
        last: json["last"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "middle": middle,
        "last": last,
      };
}
