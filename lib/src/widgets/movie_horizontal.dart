import 'package:flutter/material.dart';
import 'package:movies_app/src/models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Movie> movies;
  final Function nextPage;
  MovieHorizontal({super.key, required this.movies, required this.nextPage});
  final _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return SizedBox(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: movies.length,
        // children: _cards(context),
        itemBuilder: (context, index) => _card(context, movies[index]),
      ),
    );
  }

  Widget _card(BuildContext context, Movie movie) {
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: const AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(movie.getPosterImg()),
              fit: BoxFit.cover,
              height: 145.0,
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          )
        ],
      ),
    );
  }

  List<Widget> _cards(BuildContext context) {
    return movies.map((movie) {
      return Container(
        margin: const EdgeInsets.only(right: 10.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: const AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(movie.getPosterImg()),
                fit: BoxFit.cover,
                height: 145.0,
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
      );
    }).toList();
  }
}
