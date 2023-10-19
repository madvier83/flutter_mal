import 'package:bloc/bloc.dart';
import 'package:flutter_mal/bloc/anime_search/anime_search_event.dart';
import 'package:flutter_mal/bloc/anime_search/anime_search_state.dart';
import 'package:flutter_mal/models/api/anime_api.dart';
import 'package:flutter_mal/models/database/database_helper.dart';
import 'package:flutter_mal/models/history_model.dart';

class AnimeSearchBloc extends Bloc<AnimeSearchEvent, AnimeSearchState> {
  AnimeSearchBloc() : super(GetAnimeSearchInit()) {
    on<GetAnimeSearch>(
      (event, emit) async {
        try {
          emit(GetAnimeSearchLoading());
          await DatabaseHelper().initDatabase();
          DatabaseHelper().addHistory(HistoryModel(name: event.q));
          final animeSearch = await AnimeApi().getAnimeSearch(q: event.q);
          emit(GetAnimeSearchSuccess(animeSearch: animeSearch));
          DatabaseHelper().getHistory();
        } catch (error) {
          emit(GetAnimeSearchError(message: error.toString()));
        }
      },
    );
  }
}
