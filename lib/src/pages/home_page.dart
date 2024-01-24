import 'package:flutter/material.dart';
import 'package:movies_app/src/models/movie_model.dart';
import 'package:movies_app/src/providers/movies_provider.dart';
import 'package:movies_app/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final MoviesProvider moviesProvider = MoviesProvider();

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[_swiperCards()],
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
    // moviesProvider.getInTheaters();
    // return const ;
  }
}
