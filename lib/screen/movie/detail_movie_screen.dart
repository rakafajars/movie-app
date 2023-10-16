import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/screen/movie/detail_movie_bloc/detail_movie_bloc.dart';

class DetailMovieInitScreen extends StatelessWidget {
  final String idMovie;
  const DetailMovieInitScreen({super.key, required this.idMovie});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailMovieBloc>(
      create: (context) => DetailMovieBloc()
        ..add(
          GetDetailMovieEvent(idMovie: idMovie),
        ),
      child: const DetailMovieScreen(),
    );
  }
}

class DetailMovieScreen extends StatelessWidget {
  const DetailMovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Name"),
      ),
      body: BlocBuilder<DetailMovieBloc, DetailMovieState>(
        builder: (context, state) {
          if (state is DetailMovieLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailMovieLoaded) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Image.network(
                          "https://image.tmdb.org/t/p/w500${state.dataMovieModel.posterPath}"),
                      Container(
                        padding: const EdgeInsets.all(18),
                        margin: const EdgeInsets.only(top: 16, right: 16),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Text("${state.dataMovieModel.voteAverage}"),
                      ),
                    ],
                  ),
                  Text(state.dataMovieModel.originalTitle ?? "-"),
                  const SizedBox(height: 24),
                  Text(state.dataMovieModel.overview ?? "-"),
                ],
              ),
            );
          } else if (state is DetailMovieError) {
            return Center(
              child: Text(state.messageError),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
