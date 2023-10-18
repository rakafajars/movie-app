import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/screen/movie/detail_movie_screen.dart';
import 'package:movie_app/screen/movie/movie_recommendation/movie_recommendation_bloc.dart';

class MovieRecommendationInit extends StatelessWidget {
  final String idMovie;
  const MovieRecommendationInit({super.key, required this.idMovie});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieRecommendationBloc>(
      create: (context) => MovieRecommendationBloc()
        ..add(GetMovieRecommendationEvenet(idMovie: idMovie)),
      child: const MovieRecommendationScreen(),
    );
  }
}

class MovieRecommendationScreen extends StatelessWidget {
  const MovieRecommendationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieRecommendationBloc, MovieRecommendationState>(
      builder: (context, state) {
        if (state is MovieRecommendationLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MovieRecommendationError) {
          return Center(
            child: Text(state.messageError),
          );
        } else if (state is MovieRecommendationEmpty) {
          return const SizedBox();
        } else if (state is MovieRecommendationLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 64),
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text('Movie Recommendation'),
              ),
              // list view horizontal
              Container(
                height: 180,
                width: double.infinity,
                color: Colors.blue,
                child: ListView.builder(
                  itemCount: state.movieModel.results?.length ?? 0,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(
                    left: 16,
                  ),
                  itemBuilder: (context, index) {
                    final movieData = state.movieModel.results?[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailMovieInitScreen(
                              idMovie: movieData?.id.toString() ?? "",
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 150,
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500${movieData?.posterPath}',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(movieData?.originalTitle ?? "-"),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
