import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mal/bloc/bookmark/bookmark_state.dart';
import 'package:flutter_mal/models/anime_model.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit() : super(BookmarkInit());

  void getBookmarks() async {
    emit(BookmarkLoading());
    final User? user = FirebaseAuth.instance.currentUser;
    final data = await FirebaseFirestore.instance
        .collection("bookmarks")
        .where("user_id", isEqualTo: user!.uid)
        .get();

    List<AnimeModel> bookmarkList = [];
    for (var document in data.docs) {
      final list = AnimeModel.fromJson(document["anime"]);
      bookmarkList.add(list);
    }
    emit(BookmarkSuccess(bookmarkList: bookmarkList));
  }

  void saveBookmark(AnimeModel anime) async {
    final User? user = FirebaseAuth.instance.currentUser;
    final CollectionReference bookmarks =
        FirebaseFirestore.instance.collection("bookmarks");
    await bookmarks
        .add({"user_id": user?.uid.toString(), "anime": anime.toJson()});

    getBookmarks();
  }

  void deleteBookmark(AnimeModel anime) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      final data = await FirebaseFirestore.instance
          .collection("bookmarks")
          .where("user_id", isEqualTo: user!.uid)
          .get();

      List<AnimeModel> bookmarkList = [];
      for (var document in data.docs) {
        final list = AnimeModel.fromJson(document["anime"]);
        bookmarkList.add(list);
      }

      for (int i = 0; i < bookmarkList.length; i++) {
        if (bookmarkList[i].malId == anime.malId) {
          final documentReference = data.docs[i].reference;
          await documentReference.delete();
        }
      }

      getBookmarks();
    } catch (e) {
      // print("An error occurred while deleting the bookmark: $e");
      // Handle the error as needed, e.g., show an error message to the user.
    }
  }
}
