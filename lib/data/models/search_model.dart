import 'package:mixify/domain/entities/search.dart';

class SearchModel extends Search {
  SearchModel(
      {required super.cover,
      required super.urlSong,
      required super.artiste,
      required super.title});
  factory SearchModel.fromJson(_) => SearchModel(
    title: _["title"]?? "",
      cover: _["cover"]?? "",
      urlSong: _["urlId"]?? "",
      artiste: _["artist"]?? "",);
}
