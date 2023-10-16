import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/screen/movie/search_movie/search_movie_bloc.dart';
import 'package:movie_app/screen/movie/widget/list_movie_widget.dart';

class SearchMovieScreen extends StatefulWidget {
  const SearchMovieScreen({super.key});

  @override
  State<SearchMovieScreen> createState() => _SearchMovieScreenState();
}

class _SearchMovieScreenState extends State<SearchMovieScreen> {
  TextEditingController _searchMovieController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Search'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: _searchMovieController,
                    onFieldSubmitted: (val) {
                      // print(val);
                    },
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  context.read<SearchMovieBloc>().add(
                        GetSearchMovieEvent(
                          query: _searchMovieController.text,
                        ),
                      );
                },
                icon: const Icon(
                  Icons.search,
                ),
              )
            ],
          ),
          BlocBuilder<SearchMovieBloc, SearchMovieState>(
            builder: (contest, state) {
              if (state is SearchMovieLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SearchMovieLoaded) {
                return Expanded(
                    child: ListMoviewWidget(
                  results: state.movieModel.results,
                ));
              } else if (state is SearchMovieEmpty) {
                return const Text('Data Movie yang kamu cari tidak ada');
              } else if (state is SearchMovieError) {
                return Text(state.messageError);
              } else {
                return const SizedBox();
              }
            },
          )
        ],
      ),
    );
  }
}
