import 'package:bloc/bloc.dart';
import 'package:flutter_mal/bloc/anime_upcoming/anime_upcoming_event.dart';
import 'package:flutter_mal/bloc/anime_upcoming/anime_upcoming_state.dart';
import 'package:flutter_mal/models/api/anime_api.dart';

class AnimeUpcomingBloc extends Bloc<AnimeUpcomingEvent, AnimeUpcomingState> {
  AnimeUpcomingBloc() : super(GetAnimeUpcomingLoading()) {
    on<GetAnimeUpcoming>(
      (event, emit) async {
        try {
          emit(GetAnimeUpcomingLoading());
          final animeUpcoming = await AnimeApi().getAnimeUpcoming();
          emit(GetAnimeUpcomingSuccess(animeUpcoming: animeUpcoming));
        } catch (error) {
          emit(GetAnimeUpcomingError(message: error.toString()));
        }
      },
    );
  }
}
