import 'dart:convert';

import 'package:movies_app/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  final String _accessToken = '**';
  final String _url = 'api.themoviedb.org';
  final String _language = 'es-ES';

  Future<List<Movie>> getInTheaters() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'language': _language,
    });
    final resp = await http.get(url, headers: getHeader());
    final decodedData = json.decode(resp.body);
    final movies = Movies.fromJsonList(decodedData['results']);
    return movies.items;
  }

  getHeader() {
    return {
      'accept': 'application/json',
      'Authorization': 'Bearer $_accessToken'
    };
  }
}
