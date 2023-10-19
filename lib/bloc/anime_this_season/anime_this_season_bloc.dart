import 'package:bloc/bloc.dart';
import 'package:flutter_mal/bloc/anime_this_season/anime_this_season_event.dart';
import 'package:flutter_mal/bloc/anime_this_season/anime_this_season_state.dart';
import 'package:flutter_mal/models/api/anime_api.dart';

class AnimeThisSeasonBloc extends Bloc<AnimeThisSeasonEvent, AnimeThisSeasonState> {
  AnimeThisSeasonBloc() : super(GetAnimeThisSeasonLoading()) {
    on<GetAnimeThisSeason>(
      (event, emit) async {
        try {
          final animeThisSeason = await AnimeApi().getAnimeThisSeason();
          emit(GetAnimeThisSeasonSuccess(animeThisSeason: animeThisSeason));
        } catch (error) {
          emit(GetAnimeThisSeasonError(message: error.toString()));
        }
      },
    );
  }
}
