import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_app/model/movie_lokal_model.dart';
import 'package:movie_app/screen/movie/detail_movie_screen.dart';
import 'package:movie_app/screen/movie/list_movie_bloc/list_movie_bloc.dart';
import 'package:movie_app/screen/movie/movie_bookmark_screen.dart';
import 'package:movie_app/screen/movie/movie_web_view.dart';
import 'package:movie_app/screen/movie/search_movie_screen.dart';
import 'package:movie_app/service/service_remote/moe_service.dart';

class NewMovieScreen extends StatefulWidget {
  const NewMovieScreen({super.key});

  @override
  State<NewMovieScreen> createState() => _NewMovieScreenState();
}

class _NewMovieScreenState extends State<NewMovieScreen> {
  @override
  void initState() {
    BlocProvider.of<ListMovieBloc>(context).add(
      const GetListMovieEvent(
        idTitle: "now_playing",
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: BlocBuilder<ListMovieBloc, ListMovieState>(
        builder: (context, state) {
          if (state is ListMovieLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ListMovieLoaded) {
            return ListView.builder(
              itemCount: state.movie.results?.length,
              itemBuilder: (context, int index) {
                var movieData = state.movie.results?[index];
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
    );
  }
}