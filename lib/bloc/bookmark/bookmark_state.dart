import 'package:equatable/equatable.dart';
import 'package:flutter_mal/models/anime_model.dart';

class BookmarkState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BookmarkInit extends BookmarkState {}

class BookmarkLoading extends BookmarkState {}

class BookmarkSuccess extends BookmarkState {
  final List<AnimeModel> bookmarkList;

  BookmarkSuccess({required this.bookmarkList});
}
