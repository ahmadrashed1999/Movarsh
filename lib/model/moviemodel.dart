import 'package:get/get_connect/http/src/utils/utils.dart';

class MovieModel {
  bool? adult;
  String? backdropPath;
  List<Genres>? genres;
  int? id;
  String? overview;
  String? posterPath;
  String? releaseDate;
  //ربح
  String? tagline;
  String? title;
  double? voteAverage;
  MovieModel(
      {this.adult,
      this.backdropPath,
      this.genres,
      this.id,
      this.overview,
      this.posterPath,
      this.releaseDate,
      this.tagline,
      this.title,
      this.voteAverage,
      });

  MovieModel.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
   
    if (json['genres'] != null) {
      genres = <Genres>[];
      json['genres'].forEach((v) {
        genres!.add(new Genres.fromJson(v));
      });
    }
    id = json['id'];

    overview = json['overview'];
    posterPath = json['poster_path'];

    releaseDate = json['release_date'];


    tagline = json['tagline'];
    title = json['title'];
    voteAverage = (json['vote_average']).toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    if (this.genres != null) {
      data['genres'] = this.genres!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['overview'] = this.overview;
    data['poster_path'] = this.posterPath;

    data['release_date'] = this.releaseDate;
   

    data['tagline'] = this.tagline;
    data['title'] = this.title;
    data['vote_average'] = this.voteAverage;
    return data;
  }
}

class Genres {
  int? id;
  String? name;

  Genres({this.id, this.name});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
