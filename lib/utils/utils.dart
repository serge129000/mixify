import 'package:flutter/material.dart';
import 'package:mixify/views/pages/favorites.dart';
import 'package:mixify/views/pages/home_screen.dart';
import 'package:mixify/views/pages/profil.dart';
import 'package:mixify/views/pages/search.dart';

String kGifPath({required String gifName}) => "assets/gif/$gifName";
String kImagePath({required String imageName}) => "assets/images/$imageName";
String kIconPath({required String iconName}) => "assets/icons/$iconName";
Size kSize(_) => MediaQuery.of(_).size;
kPushToPage({required BuildContext context, required Widget page}) =>
    Navigator.push(context, slidableRoute(nextPage: page));
kReplaceToPage({required BuildContext context, required Widget page}) =>
    Navigator.pushReplacement(context, slidableRoute(nextPage: page));
kPopPage({required BuildContext context}) => Navigator.pop(context);
Route slidableRoute({required Widget nextPage}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => nextPage,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

//
Route slidableRouteToUp({required Widget nextPage}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => nextPage,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(0, 1);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

kUpToPage({required BuildContext context, required Widget page}) =>
    Navigator.push(context, slidableRoute(nextPage: page));

enum PageName { dashboard, search, favorites, profil }

Map<PageName, Widget> pageNameAccordingToPage = {
  PageName.dashboard: const HomeScreen(),
  PageName.search: const Search(),
  PageName.favorites: const Favorites(),
  PageName.profil: const Profil()
};
const String databaseName = "mixify.db";
List<Map<String, dynamic>> bottomMenuData = [
  {
    "icon": "home.png",
    "page": PageName.dashboard,
  },
  {
    "icon": "search.png",
    "page": PageName.search,
  },
  {
    "icon": "fav.png",
    "page": PageName.favorites,
  },
  {
    "icon": "user.png",
    "page": PageName.profil,
  }
];

enum Status { initial, loading, loaded, error }

String timeFormtter(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hour = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return [if (duration.inHours > 0) hour, minutes, seconds].join(':');
}
