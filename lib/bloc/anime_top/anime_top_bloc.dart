import 'package:bloc/bloc.dart';
import 'package:flutter_mal/bloc/anime_top/anime_top_event.dart';
import 'package:flutter_mal/bloc/anime_top/anime_top_state.dart';
import 'package:flutter_mal/models/api/anime_api.dart';

class AnimeTopBloc extends Bloc<AnimeTopEvent, AnimeTopState> {
  AnimeTopBloc() : super(GetAnimeTopLoading()) {
    on<GetAnimeTop>(
      (event, emit) async {
        try {
          emit(GetAnimeTopLoading());
          final animeTop = await AnimeApi().getAnimeTop();
          emit(GetAnimeTopSuccess(animeTop: animeTop));
        } catch (error) {
          emit(GetAnimeTopError(message: error.toString()));
        }
      },
    );
  }
}
