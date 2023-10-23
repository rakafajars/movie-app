import 'package:flutter/material.dart';
import 'package:movie_app/model/data_movie_model.dart';
import 'package:movie_app/model/movie_lokal_model.dart';
import 'package:movie_app/screen/movie/detail_movie_screen.dart';

class ListMoviewWidget extends StatelessWidget {
  final List<DataMovieModel>? results;
  const ListMoviewWidget({super.key, this.results});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: results?.sublist(0, 2).length,
      itemBuilder: (context, int index) {
        var movieData = results?[index];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailMovieInitScreen(
                idMovie: movieData?.id.toString() ?? "",
                movieLokalModel: MovieLokalModel(
                  id: movieData?.id,
                  title: movieData?.originalTitle,
                  posterPath: movieData?.posterPath,
                  overview: movieData?.overview,
                ),
              ),
            ),
          ),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Image.network(
                        "https://image.tmdb.org/t/p/w500${movieData?.posterPath}"),
                    Container(
                      padding: const EdgeInsets.all(18),
                      margin: const EdgeInsets.only(top: 16, right: 16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Text("${movieData?.voteAverage}"),
                    ),
                  ],
                ),
                Text(movieData?.originalTitle ?? "-"),
                const SizedBox(height: 24),
                Text(movieData?.overview ?? "-"),
              ],
            ),
          ),
        );
      },
    );
  }
}
