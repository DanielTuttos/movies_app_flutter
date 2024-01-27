import 'package:flutter/material.dart';
import 'package:movies_app/src/models/movie_model.dart';
import 'package:movies_app/src/providers/movies_provider.dart';
import 'package:movies_app/src/search/search_delegate.dart';
import 'package:movies_app/src/widgets/card_swiper_widget.dart';
import 'package:movies_app/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final MoviesProvider moviesProvider = MoviesProvider();

  @override
  Widget build(BuildContext context) {
    moviesProvider.getPopulars();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Peliculas en cines',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch(),
              );
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperCards(),
            _footer(context),
          ],
        ),
      ),
    );
  }

  Widget _swiperCards() {
    return FutureBuilder(
      future: moviesProvider.getInTheaters(),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        var movies = snapshot.data;
        if (movies != null) {
          return CardSwiper(movies: movies);
        }
        return const SizedBox(
          height: 500.0,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text('Populares',
                style: Theme.of(context).textTheme.headlineSmall),
          ),
          const SizedBox(
            height: 5.0,
          ),
          StreamBuilder(
            stream: moviesProvider.popularsStream,
            builder:
                (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
              var movies = snapshot.data;
              if (movies != null) {
                return MovieHorizontal(
                  movies: movies,
                  nextPage: moviesProvider.getPopulars,
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          )
        ],
      ),
    );
  }
}
