// import 'package:flutter_mal/models/anime_model.dart';

import 'package:flutter_mal/models/anime_model.dart';

class AnimeSearchState {
  const AnimeSearchState();
}

// LOADING state
class GetAnimeSearchInit extends AnimeSearchState {}

class GetAnimeSearchLoading extends AnimeSearchState {}

// SUCCESS state
class GetAnimeSearchSuccess extends AnimeSearchState {
  final List<AnimeModel> animeSearch;

  GetAnimeSearchSuccess({
    required this.animeSearch,
  });
}

// ERROR state
class GetAnimeSearchError extends AnimeSearchState {
  final String message;

  GetAnimeSearchError({
    required this.message,
  });
}
