// import 'package:flutter_mal/models/anime_model.dart';

import 'package:flutter_mal/models/anime_model.dart';

class AnimeTopState {
  const AnimeTopState();
}

// LOADING state
class GetAnimeTopLoading extends AnimeTopState {}

// SUCCESS state
class GetAnimeTopSuccess extends AnimeTopState {
  final List<AnimeModel> animeTop;

  GetAnimeTopSuccess({
    required this.animeTop,
  });
}

// ERROR state
class GetAnimeTopError extends AnimeTopState {
  final String message;

  GetAnimeTopError({
    required this.message,
  });
}
