import 'package:dio/dio.dart';
import 'package:movie_app/model/data_movie_model.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/model/person_popular_model.dart';

class MovieService {
  Future<MovieModel> getMovieListByParameter({
    required String typeMovie,
  }) async {
    try {
      final response = await Dio().get(
        'https://api.themoviedb.org/3/movie/$typeMovie?language=en-US&page=1',
        options: Options(
          headers: {
            "Authorization":
                "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwYjBkZWJlMDUzNTM1NGZkNDViM2I4NmE4MWZkMzVhMiIsInN1YiI6IjVlNjk5ZGU4Y2VkYWM0MDAxNTQ2YmMyYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.X6XeWeTtRu1bibtfYujUyi_m0bdVmwK8bFastHyZVfk",
          },
        ),
      );

      return MovieModel.fromJson(response.data);
    } catch (e) {
      throw '$e';
    }
  }

  Future<PersonPopularModel> getPersonPopular() async {
    try {
      final response = await Dio().get(
        'https://api.themoviedb.org/3/person/popular',
        options: Options(
          headers: {
            "Authorization":
                "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwYjBkZWJlMDUzNTM1NGZkNDViM2I4NmE4MWZkMzVhMiIsInN1YiI6IjVlNjk5ZGU4Y2VkYWM0MDAxNTQ2YmMyYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.X6XeWeTtRu1bibtfYujUyi_m0bdVmwK8bFastHyZVfk",
          },
        ),
      );

      return PersonPopularModel.fromJson(response.data);
    } catch (e) {
      throw '$e';
    }
  }

  Future<MovieModel> searchMovie({
    required String query,
  }) async {
    try {
      final response = await Dio().get(
        'https://api.themoviedb.org/3/search/movie?query=$query',
        options: Options(
          headers: {
            "Authorization":
                "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwYjBkZWJlMDUzNTM1NGZkNDViM2I4NmE4MWZkMzVhMiIsInN1YiI6IjVlNjk5ZGU4Y2VkYWM0MDAxNTQ2YmMyYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.X6XeWeTtRu1bibtfYujUyi_m0bdVmwK8bFastHyZVfk",
          },
        ),
      );

      return MovieModel.fromJson(response.data);
    } catch (e) {
      throw '$e';
    }
  }

  Future<DataMovieModel> getMovieDetail({required String idDetail}) async {
    try {
      final response = await Dio().get(
        'https://api.themoviedb.org/3/movie/$idDetail',
        options: Options(
          headers: {
            "Authorization":
                "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwYjBkZWJlMDUzNTM1NGZkNDViM2I4NmE4MWZkMzVhMiIsInN1YiI6IjVlNjk5ZGU4Y2VkYWM0MDAxNTQ2YmMyYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.X6XeWeTtRu1bibtfYujUyi_m0bdVmwK8bFastHyZVfk",
          },
        ),
      );

      return DataMovieModel.fromJson(response.data);
    } catch (e) {
      throw '$e';
    }
  }

  Future<MovieModel> getMovieRecommendation({required String idMovie}) async {
    try {
      final response = await Dio().get(
        'https://api.themoviedb.org/3/movie/$idMovie/recommendations',
        options: Options(
          headers: {
            "Authorization":
                "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwYjBkZWJlMDUzNTM1NGZkNDViM2I4NmE4MWZkMzVhMiIsInN1YiI6IjVlNjk5ZGU4Y2VkYWM0MDAxNTQ2YmMyYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.X6XeWeTtRu1bibtfYujUyi_m0bdVmwK8bFastHyZVfk",
          },
        ),
      );

      return MovieModel.fromJson(response.data);
    } catch (e) {
      throw '$e';
    }
  }
}
