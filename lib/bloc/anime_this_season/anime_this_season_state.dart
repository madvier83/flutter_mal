// import 'package:flutter_mal/models/anime_model.dart';

import 'package:flutter_mal/models/anime_model.dart';

class AnimeThisSeasonState {
  const AnimeThisSeasonState();
}

// LOADING state
class GetAnimeThisSeasonLoading extends AnimeThisSeasonState {}

// SUCCESS state
class GetAnimeThisSeasonSuccess extends AnimeThisSeasonState {
  final List<AnimeModel> animeThisSeason;

  GetAnimeThisSeasonSuccess({
    required this.animeThisSeason,
  });
}

// ERROR state
class GetAnimeThisSeasonError extends AnimeThisSeasonState {
  final String message;

  GetAnimeThisSeasonError({
    required this.message,
  });
}
