import 'package:equatable/equatable.dart';

abstract class AnimeSearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAnimeSearch extends AnimeSearchEvent {
  final String q;
  GetAnimeSearch({required this.q});
}
