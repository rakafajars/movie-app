import 'package:movie_app/model/movie_lokal_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static late Database _database;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  String movieTabel = 'movieTabel';

  Future<Database> _initializeDb() async {
    var db = openDatabase(
      join(
        await getDatabasesPath(),
        'movie_db.db',
      ),
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $movieTabel(
          id INTEGER PRIMARY KEY,
          title TEXT,
          posterPath TEXT,
          overview TEXT
        )''');
      },
      version: 1,
    );

    return db;
  }

  // INSERT MOVIE
  Future<void> insertMovie(MovieLokalModel movieLokalModel) async {
    final db = await database;
    await db.insert(movieTabel, movieLokalModel.toMap());
  }

  // DELETE MOVIE
  Future<void> deleteMovie(int id) async {
    final db = await database;
    await db.delete(movieTabel, where: "id = ?", whereArgs: [id]);
  }

  // GET MOVIEBYID
  Future<MovieLokalModel> getMovieById(int id) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      movieTabel,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return result.map((e) => MovieLokalModel.fromMap(e)).toList().first;
    } else {
      return MovieLokalModel();
    }
  }

  // Get List Moview Local DB
  Future<List<MovieLokalModel>> getListMovieLocal() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      movieTabel,
    );

    return result.map((e) => MovieLokalModel.fromMap(e)).toList();
  }
}
