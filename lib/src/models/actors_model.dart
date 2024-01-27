class Cast {
  List<Actor> actors = [];
  Cast();
  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final actor = Actor.fromJsonMap(item);
      actors.add(actor);
    }
  }
}

class Actor {
  late bool adult;
  late int gender;
  late int id;
  late String name;
  late String originalName;
  late double popularity;
  String? profilePath;
  late int castId;
  late String character;
  late String creditId;
  late int order;
  String? department;
  String? job;
  late String knownForDepartment;

  Actor({
    required this.adult,
    required this.gender,
    required this.id,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
    this.department,
    this.job,
    required this.knownForDepartment,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    originalName = json['original_name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    order = json['order'];
    department = json['department'];
    job = json['job'];
    knownForDepartment = json['known_for_department'];
  }
  getPhoto() {
    if (profilePath == null) {
      return 'https://img.freepik.com/premium-vector/user-profile-icon-flat-style-member-avatar-vector-illustration-isolated-background-human-permission-sign-business-concept_157943-15752.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500$profilePath';
    }
  }
}
