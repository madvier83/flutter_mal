import 'package:bloc/bloc.dart';
import 'package:flutter_mal/bloc/anime_search/anime_search_event.dart';
import 'package:flutter_mal/bloc/anime_search/anime_search_state.dart';
import 'package:flutter_mal/models/api/anime_api.dart';

class AnimeSearchBloc extends Bloc<AnimeSearchEvent, AnimeSearchState> {
  AnimeSearchBloc() : super(GetAnimeSearchInit()) {
    on<GetAnimeSearch>(
      (event, emit) async {
        try {
          emit(GetAnimeSearchLoading());
          final animeSearch = await AnimeApi().getAnimeSearch(q: event.q);
          emit(GetAnimeSearchSuccess(animeSearch: animeSearch));
        } catch (error) {
          emit(GetAnimeSearchError(message: error.toString()));
        }
      },
    );
  }
}
