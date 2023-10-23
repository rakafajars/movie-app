import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/screen/movie/detail_movie_bloc/detail_movie_bloc.dart';
import 'package:movie_app/screen/movie/list_movie_bloc/list_movie_bloc.dart';
import 'package:movie_app/screen/movie/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:movie_app/screen/movie/new_movie_screen.dart';
import 'package:movie_app/screen/movie/person_popular_bloc/person_popular_bloc.dart';
import 'package:movie_app/screen/movie/search_movie/search_movie_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ListMovieBloc>(create: (context) => ListMovieBloc()),
        BlocProvider<PersonPopularBloc>(
            create: (context) => PersonPopularBloc()),
        BlocProvider<SearchMovieBloc>(create: (context) => SearchMovieBloc()),
        BlocProvider<DetailMovieBloc>(create: (context) => DetailMovieBloc()),
        BlocProvider<MovieRecommendationBloc>(
            create: (context) => MovieRecommendationBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const NewMovieScreen(),
      ),
    );
  }
}
