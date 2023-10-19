// import 'package:flutter_mal/models/anime_model.dart';

import 'package:flutter_mal/models/anime_model.dart';

class AnimeUpcomingState {
  const AnimeUpcomingState();
}

// LOADING state
class GetAnimeUpcomingLoading extends AnimeUpcomingState {}

// SUCCESS state
class GetAnimeUpcomingSuccess extends AnimeUpcomingState {
  final List<AnimeModel> animeUpcoming;

  GetAnimeUpcomingSuccess({
    required this.animeUpcoming,
  });
}

// ERROR state
class GetAnimeUpcomingError extends AnimeUpcomingState {
  final String message;

  GetAnimeUpcomingError({
    required this.message,
  });
}
