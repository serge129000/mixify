import 'package:flutter/foundation.dart';
import 'package:mixify/utils/utils.dart';

class PageProvider with ChangeNotifier {
  PageName _pageName = PageName.dashboard;
  PageName get pageName => _pageName;
  void setNewChangePage({required PageName npageName}) {
    _pageName = npageName;
    notifyListeners();
  }
}
