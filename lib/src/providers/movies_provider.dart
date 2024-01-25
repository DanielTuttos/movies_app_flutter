import 'dart:async';
import 'dart:convert';

import 'package:movies_app/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  final String _accessToken = '**';
  final String _url = 'api.themoviedb.org';
  final String _language = 'es-ES';
  int _popularsPage = 0;
  bool _loading = false;

  List<Movie> _populars = [];
  final _popularsStreamController = StreamController<List<Movie>>.broadcast();
  Function(List<Movie>) get popularsSink => _popularsStreamController.sink.add;
  Stream<List<Movie>> get popularsStream => _popularsStreamController.stream;

  void disposeStreams() {
    _popularsStreamController?.close();
  }

  Future<List<Movie>> _processResponse(Uri uri) async {
    final resp = await http.get(uri, headers: getHeader());
    final decodedData = json.decode(resp.body);
    final movies = Movies.fromJsonList(decodedData['results']);
    return movies.items;
  }

  Future<List<Movie>> getInTheaters() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'language': _language,
    });
    return await _processResponse(url);
  }

  Future<List<Movie>> getPopulars() async {
    if (_loading) return [];
    _loading = true;
    _popularsPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'language': _language,
      'page': _popularsPage.toString(),
    });
    final resp = await _processResponse(url);
    _populars.addAll(resp);
    popularsSink(_populars);
    _loading = false;
    return resp;
  }

  getHeader() {
    return {
      'accept': 'application/json',
      'Authorization': 'Bearer $_accessToken'
    };
  }
}
