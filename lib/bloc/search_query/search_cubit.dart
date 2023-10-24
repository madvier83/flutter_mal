import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mal/bloc/search_query/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState());

  void setSearchQuery({required String q}) {
    emit(SearchState());
  }
}
