import 'package:dio/dio.dart';
import 'package:flutter_mal/constants/url.dart';
import 'package:flutter_mal/models/anime_model.dart';

class AnimeApi {
  final Dio dio = Dio();

  Future<List<AnimeModel>> getAnimeThisSeason() async {
    List<AnimeModel> data = [];
    try {
      final response = await dio.get("${Url().jikanApi}seasons/now");
      (response.data["data"] as Iterable)
          .map((e) => data.add(AnimeModel.fromJson(e)))
          .toList();
      return data;
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }

  Future<List<AnimeModel>> getAnimeUpcoming() async {
    List<AnimeModel> data = [];
    try {
      final response = await dio.get("${Url().jikanApi}seasons/upcoming");
      (response.data["data"] as Iterable)
          .map((e) => data.add(AnimeModel.fromJson(e)))
          .toList();
      return data;
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }

  Future<List<AnimeModel>> getAnimeTop() async {
    List<AnimeModel> data = [];
    try {
      final response = await dio.get("${Url().jikanApi}top/anime");
      (response.data["data"] as Iterable)
          .map((e) => data.add(AnimeModel.fromJson(e)))
          .toList();
      return data;
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }

  Future<List<AnimeModel>> getAnimeSearch({required String q}) async {
    List<AnimeModel> data = [];
    try {
      final response = await dio.get("${Url().jikanApi}anime",
          queryParameters: {"q": q, "sfw": true});
      (response.data["data"] as Iterable)
          .map((e) => data.add(AnimeModel.fromJson(e)))
          .toList();
      // print(data);
      return data;
    } catch (e) {
      throw Exception("An error occurred: $e");
    }
  }
}
