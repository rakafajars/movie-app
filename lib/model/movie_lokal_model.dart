class MovieLokalModel {
  int? id;
  String? title;
  String? posterPath;
  String? overview;

  MovieLokalModel({
    this.id,
    this.title,
    this.posterPath,
    this.overview,
  });

  MovieLokalModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    posterPath = map['posterPath'];
    overview = map['overview'];
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "overview": overview,
        "posterPath": posterPath,
      };
}
