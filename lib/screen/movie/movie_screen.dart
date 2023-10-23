import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_app/model/model_type.dart';
import 'package:movie_app/screen/movie/list_movie_bloc/list_movie_bloc.dart';
import 'package:movie_app/screen/movie/movie_bookmark_screen.dart';
import 'package:movie_app/screen/movie/movie_web_view.dart';
import 'package:movie_app/screen/movie/person_popular_bloc/person_popular_bloc.dart';
import 'package:movie_app/screen/movie/search_movie_screen.dart';
import 'package:movie_app/screen/movie/widget/list_movie_widget.dart';
import 'package:movie_app/service/service_remote/moe_service.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  List<ModelType> typeMovieList = [
    ModelType(title: "Now Playing", idTitle: 'now_playing'),
    ModelType(title: "Popular", idTitle: 'popular'),
    ModelType(title: "Top Rated", idTitle: 'top_rated'),
    ModelType(title: "Upcoming", idTitle: 'upcoming'),
    ModelType(idTitle: '', title: 'Artis')
  ];

  @override
  void initState() {
    BlocProvider.of<ListMovieBloc>(context).add(
      GetListMovieEvent(idTitle: typeMovieList[0].idTitle, page: 1),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Movie List'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchMovieScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MovieBookScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.save),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MovieWebView(),
                  ),
                );
              },
              icon: const Icon(Icons.web),
            ),
            IconButton(
              onPressed: () async {
                XFile? xFile;
                final ImagePicker picker = ImagePicker();

                xFile = await picker.pickImage(
                  source: ImageSource.gallery,
                );

                if (xFile != null) {
                  await MoeService().getMoe(
                    xfile: xFile,
                  );
                }
              },
              icon: const Icon(
                Icons.image,
              ),
            ),
          ],
          bottom: TabBar(
            onTap: (val) {
              if (typeMovieList[val].title == "Artis") {
                context.read<PersonPopularBloc>().add(GetPersonPopularEvent());
              } else {
                context.read<ListMovieBloc>().add(GetListMovieEvent(
                    idTitle: typeMovieList[val].idTitle, page: 1));
              }
            },
            isScrollable: true,
            tabs: typeMovieList
                .map(
                  (movie) => Tab(
                    child: Text(movie.title),
                  ),
                )
                .toList(),
          ),
        ),
        body: TabBarView(
          children: [
            // UI NOW PLAYING
            BlocBuilder<ListMovieBloc, ListMovieState>(
              builder: (context, state) {
                if (state is ListMovieLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ListMovieLoaded) {
                  return ListMoviewWidget(
                    results: state.movie.results,
                  );
                } else if (state is ListMovieEmpty) {
                  return const Center(
                    child: Text(
                      'Movie Kosong',
                    ),
                  );
                } else if (state is ListMovieError) {
                  return Center(
                    child: Text(
                      state.messageError,
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            // UI popular

            BlocBuilder<ListMovieBloc, ListMovieState>(
              builder: (context, state) {
                if (state is ListMovieLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ListMovieLoaded) {
                  return ListMoviewWidget(
                    results: state.movie.results,
                  );
                } else if (state is ListMovieEmpty) {
                  return const Center(
                    child: Text(
                      'Movie Kosong',
                    ),
                  );
                } else if (state is ListMovieError) {
                  return Center(
                    child: Text(
                      state.messageError,
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),

            // UI Top Rated
            BlocBuilder<ListMovieBloc, ListMovieState>(
              builder: (context, state) {
                if (state is ListMovieLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ListMovieLoaded) {
                  return ListMoviewWidget(
                    results: state.movie.results,
                  );
                } else if (state is ListMovieEmpty) {
                  return const Center(
                    child: Text(
                      'Movie Kosong',
                    ),
                  );
                } else if (state is ListMovieError) {
                  return Center(
                    child: Text(
                      state.messageError,
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),

            // UI UpComing
            BlocBuilder<ListMovieBloc, ListMovieState>(
              builder: (context, state) {
                if (state is ListMovieLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ListMovieLoaded) {
                  return ListMoviewWidget(
                    results: state.movie.results,
                  );
                } else if (state is ListMovieEmpty) {
                  return const Center(
                    child: Text(
                      'Movie Kosong',
                    ),
                  );
                } else if (state is ListMovieError) {
                  return Center(
                    child: Text(
                      state.messageError,
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),

            /// UI ARTIS
            BlocBuilder<PersonPopularBloc, PersonPopularState>(
              builder: (context, state) {
                if (state is PersonPopularLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PersonPopularLoaded) {
                  return ListView.builder(
                    itemCount: state.personPopularModel.results?.length,
                    itemBuilder: (context, int index) {
                      var data = state.personPopularModel.results?[index];

                      return Image.network(
                        "https://image.tmdb.org/t/p/w500${data?.profilePath}",
                      );
                    },
                  );
                } else if (state is PersonPopularError) {
                  return Center(
                    child: Text(
                      state.messageError,
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
