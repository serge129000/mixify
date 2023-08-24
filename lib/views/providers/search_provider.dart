import 'package:flutter/foundation.dart';
import 'package:mixify/data/models/search_model.dart';
import 'package:mixify/data/source/search_source.dart';

import '../../utils/utils.dart';

class SearchProvider with ChangeNotifier {
  List<SearchModel>? _searchResults;
  List<SearchModel>? get searchResults => _searchResults;
  Status _status = Status.initial;
  Status get status => _status;
  Future<void> searchMusiques({required String searchQuery}) async {
    _status = Status.loading;
    notifyListeners();
    try {
      _searchResults =
          await SearchSource().searchedMusique(searchQuery: searchQuery);
      _status = Status.loaded;
      notifyListeners();
    } catch (e) {
      _status = Status.error;
      notifyListeners();
    }
  }
}
