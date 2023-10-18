import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/model/movie_lokal_model.dart';
import 'package:movie_app/screen/movie/detail_movie_bloc/detail_movie_bloc.dart';
import 'package:movie_app/screen/movie/movie_recommendation_screen.dart';
import 'package:movie_app/service/service_local/db_helper.dart';

class DetailMovieInitScreen extends StatelessWidget {
  final String idMovie;
  final MovieLokalModel movieLokalModel;
  const DetailMovieInitScreen(
      {super.key, required this.idMovie, required this.movieLokalModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailMovieBloc>(
      create: (context) => DetailMovieBloc()
        ..add(
          GetDetailMovieEvent(idMovie: idMovie),
        ),
      child: DetailMovieScreen(
        idMovie: idMovie,
        movieLokalModel: movieLokalModel,
      ),
    );
  }
}

class DetailMovieScreen extends StatefulWidget {
  final String idMovie;
  final MovieLokalModel movieLokalModel;

  const DetailMovieScreen(
      {super.key, required this.idMovie, required this.movieLokalModel});

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  DatabaseHelper dbHelper = DatabaseHelper();
  // ini property nilai yang akan di dapat dari fungsi
  // dbHelper getMovieById
  MovieLokalModel? _movieLokalModel;

  void getMovieById(int id) async {
    _movieLokalModel = await dbHelper.getMovieById(id);
    setState(() {});
  }

  @override
  void initState() {
    getMovieById(int.parse(widget.idMovie));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Name"),
        actions: [
          IconButton(
            onPressed: () async {
              if (_movieLokalModel?.id == widget.movieLokalModel.id) {
                await dbHelper
                    .deleteMovie(widget.movieLokalModel.id?.toInt() ?? 0);
                _movieLokalModel = null;

                setState(() {});
              } else {
                await dbHelper.insertMovie(widget.movieLokalModel);
                getMovieById(int.parse(widget.idMovie));
              }
            },
            icon: _movieLokalModel?.id == widget.movieLokalModel.id
                ? const Icon(
                    Icons.bookmark,
                  )
                : const Icon(
                    Icons.bookmark_border,
                  ),
          ),
        ],
      ),
      body: BlocBuilder<DetailMovieBloc, DetailMovieState>(
        builder: (context, state) {
          if (state is DetailMovieLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailMovieLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 64),
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
                  MovieRecommendationInit(
                    idMovie: widget.idMovie,
                  ),
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
