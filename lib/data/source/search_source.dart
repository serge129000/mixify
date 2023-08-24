import 'package:mixify/data/models/search_model.dart';
import 'package:mixify/google_credentials/auth_credentials.dart';

class SearchSource {
  static Future<List<Map<String, dynamic>>> search(
      {required String searchQuery}) async {
    try {
      final search = await GoogleAuthCredentials.youTubeApi.search
          .list(["id", "snippet"], q: searchQuery, type: ["video"], maxResults: 5);
      List<Map<String, dynamic>> searchResult = [];
      for (var element in search.items!) {
        searchResult.add({
          "cover": element.snippet!.thumbnails!.high!.url,
          "urlId": element
              .id!.videoId,
          "artist": element.snippet!.channelTitle,
          "title": element.snippet!.title
        });
      }
      return searchResult;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SearchModel>> searchedMusique(
      {required String searchQuery}) async {
    try {
      List<Map<String, dynamic>> allSearchresult =
          await search(searchQuery: searchQuery);
      //print(allSearchresult);
      return allSearchresult.map((e) => SearchModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
