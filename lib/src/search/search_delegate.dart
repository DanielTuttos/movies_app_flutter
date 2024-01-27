import 'package:flutter/material.dart';
import 'package:movies_app/src/models/movie_model.dart';
import 'package:movies_app/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate {
  final movies = [
    'Spiderman',
    'Aquaman',
    'Batman',
    'Shazam',
    'Capitan America: El primer vengador',
    'Capitan America y el soldado del invierno',
    'Capitan America: Guerra civil',
    'Superman',
    'IronMan 1',
    'IronMan 2',
    'IronMan 3',
  ];
  final recentMovies = ['Spiderman', 'Capitan America'];

  String selection = '';
  final moviesProvider = MoviesProvider();

  @override
  List<Widget>? buildActions(BuildContext context) {
    // las acciones de nuestro appbar, como cancelar o limpiar
    return <Widget>[
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // icono a la izquierda del appbar
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // crea los resultados que se van a mostrar
    return const Center();
    // return Center(
    //   child: Container(
    //     height: 100.0,
    //     width: 100.0,
    //     color: Colors.amber,
    //     child: Text(selection),
    //   ),
    // );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // las sugerencias que aparecen cuando la persona escribe
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data;
          return ListView(
            children: movies!.map((movie) {
              return ListTile(
                leading: FadeInImage(
                  placeholder: const AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(movie.getPosterImg()),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(movie.title),
                subtitle: Text(movie.originalTitle),
                onTap: () {
                  close(context, null);
                  movie.uniqueId = '';
                  Navigator.pushNamed(context, 'detail', arguments: movie);
                },
              );
            }).toList(),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // ejemplo
  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // las sugerencias que aparecen cuando la persona escribe

  //   final suggestionList = (query.isEmpty)
  //       ? recentMovies
  //       : movies
  //           .where(
  //               (movie) => movie.toLowerCase().startsWith(query.toLowerCase()))
  //           .toList();

  //   return ListView.builder(
  //     itemBuilder: (context, index) {
  //       return ListTile(
  //         leading: const Icon(Icons.movie),
  //         title: Text(suggestionList[index]),
  //         onTap: () {
  //           selection = suggestionList[index];
  //           showResults(context);
  //         },
  //       );
  //     },
  //     itemCount: suggestionList.length,
  //   );
  // }
}
