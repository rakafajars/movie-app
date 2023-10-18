import 'package:flutter/material.dart';
import 'package:movie_app/model/movie_lokal_model.dart';
import 'package:movie_app/screen/movie/detail_movie_screen.dart';
import 'package:movie_app/service/service_local/db_helper.dart';

class MovieBookScreen extends StatefulWidget {
  const MovieBookScreen({super.key});

  @override
  State<MovieBookScreen> createState() => _MovieBookScreenState();
}

class _MovieBookScreenState extends State<MovieBookScreen> {
  List<MovieLokalModel> _movieLokalModel = [];

  DatabaseHelper _databaseHelper = DatabaseHelper();

  void getMovieLokal() async {
    _movieLokalModel = await _databaseHelper.getListMovieLocal();
    setState(() {});
  }

  @override
  void initState() {
    getMovieLokal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Bookmark'),
      ),
      body: ListView.builder(
        itemCount: _movieLokalModel.length,
        itemBuilder: (context, index) {
          var movieData = _movieLokalModel[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailMovieInitScreen(
                  idMovie: movieData.id.toString(),
                  movieLokalModel: MovieLokalModel(
                    id: movieData.id,
                    title: movieData.title,
                    posterPath: movieData.posterPath,
                    overview: movieData.overview,
                  ),
                ),
              ),
            ).then((value) => getMovieLokal()),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                      "https://image.tmdb.org/t/p/w500${movieData.posterPath}"),
                  Text(movieData.title ?? "-"),
                  const SizedBox(height: 24),
                  Text(movieData.overview ?? "-"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
