class TvModel {
  bool? adult;
  String? backdropPath;
  List? createdBy;
  List<Genres>? genres;
  String? homepage;
  int? id;
  bool? inProduction;
  List<String>? languages;
  String? name;
  List<Networks>? networks;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  List<Seasons>? seasons;
  String? status;
  String? tagline;
  String? firstAirDate;
  String? type;
  double? voteAverage;
  int? voteCount;

  TvModel(
      {this.adult,
      this.backdropPath,
      this.createdBy,
      this.genres,
      this.homepage,
      this.id,
      this.inProduction,
      this.languages,
      this.name,
      this.networks,
      this.numberOfEpisodes,
      this.numberOfSeasons,
      this.originalLanguage,
      this.originalName,
      this.overview,
      this.firstAirDate,
      this.popularity,
      this.posterPath,
      this.seasons,
      this.status,
      this.tagline,
      this.type,
      this.voteAverage,
      this.voteCount});

  TvModel.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    firstAirDate = json['first_air_date'];
    backdropPath = json['backdrop_path'];
    if (json['genres'] != null) {
      genres = <Genres>[];
      json['genres'].forEach((v) {
        genres!.add(new Genres.fromJson(v));
      });
    }
    homepage = json['homepage'];
    id = json['id'];
    inProduction = json['in_production'];
    languages = json['languages'].cast<String>();

    name = json['name'];
    if (json['networks'] != null) {
      networks = <Networks>[];
      json['networks'].forEach((v) {
        networks!.add(new Networks.fromJson(v));
      });
    }
    numberOfEpisodes = json['number_of_episodes'];
    numberOfSeasons = json['number_of_seasons'];

    originalLanguage = json['original_language'];
    originalName = json['original_name'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];

    if (json['seasons'] != null) {
      seasons = <Seasons>[];
      json['seasons'].forEach((v) {
        seasons!.add(new Seasons.fromJson(v));
      });
    }

    status = json['status'];
    tagline = json['tagline'];
    type = json['type'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
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

class Networks {
  int? id;
  String? name;
  String? logoPath;
  String? originCountry;

  Networks({this.id, this.name, this.logoPath, this.originCountry});

  Networks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logoPath = json['logo_path'];
    originCountry = json['origin_country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo_path'] = this.logoPath;
    data['origin_country'] = this.originCountry;
    return data;
  }
}

class Seasons {
  String? airDate;
  int? episodeCount;
  int? id;
  String? name;
  String? overview;
  String? posterPath;
  int? seasonNumber;

  Seasons(
      {this.airDate,
      this.episodeCount,
      this.id,
      this.name,
      this.overview,
      this.posterPath,
      this.seasonNumber});

  Seasons.fromJson(Map<String, dynamic> json) {
    airDate = json['air_date'];
    episodeCount = json['episode_count'];
    id = json['id'];
    name = json['name'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    seasonNumber = json['season_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['air_date'] = this.airDate;
    data['episode_count'] = this.episodeCount;
    data['id'] = this.id;
    data['name'] = this.name;
    data['overview'] = this.overview;
    data['poster_path'] = this.posterPath;
    data['season_number'] = this.seasonNumber;
    return data;
  }
}
