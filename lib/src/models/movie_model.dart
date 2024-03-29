// Generated by https://quicktype.io

class Movies {
  List<Movie> items = [];
  Movies();
  Movies.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final movie = Movie.fromJsonMap(item);
      items.add(movie);
    }
  }
}

class Movie {
  late String uniqueId;
  late int voteCount;
  late int id;
  late bool video;
  late double voteAverage;
  late String title;
  late double popularity;
  late String posterPath;
  late String originalLanguage;
  late String originalTitle;
  late List<int> genreIds;
  String? backdropPath;
  late bool adult;
  late String overview;
  late String releaseDate;

  Movie({
    required this.voteCount,
    required this.id,
    required this.video,
    required this.voteAverage,
    required this.title,
    required this.popularity,
    required this.posterPath,
    required this.originalLanguage,
    required this.originalTitle,
    required this.genreIds,
    required this.backdropPath,
    required this.adult,
    required this.overview,
    required this.releaseDate,
  });

  Movie.fromJsonMap(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'] / 1;
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'] / 1;
    voteCount = json['vote_count'];
  }

  getPosterImg() {
    if (posterPath == null) {
      return 'https://cdn.vectorstock.com/i/preview-1x/48/06/image-preview-icon-picture-placeholder-vector-31284806.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500$posterPath';
    }
  }

  getBackgroundImg() {
    if (posterPath == null) {
      return 'https://cdn.vectorstock.com/i/preview-1x/48/06/image-preview-icon-picture-placeholder-vector-31284806.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500$backdropPath';
    }
  }
}
