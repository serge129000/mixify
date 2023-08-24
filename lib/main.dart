import 'package:flutter/material.dart';
import 'package:mixify/utils/constants.dart';
import 'package:mixify/views/pages/auth/landing_page.dart';
import 'package:mixify/views/providers/audio_provider.dart';
import 'package:mixify/views/providers/music_provider.dart';
import 'package:mixify/views/providers/page_provider.dart';
import 'package:mixify/views/providers/search_provider.dart';
import 'package:mixify/views/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PageProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => MusicProvider()),
        ChangeNotifierProvider(create: (_) => AudioProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return ScrollConfiguration(behavior: MyBehavior(), child: child!);
        },
        theme: ThemeData(
          useMaterial3: true,
            inputDecorationTheme: const InputDecorationTheme(
                iconColor: kPrimaryColor,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                filled: true,
                fillColor: Color(0xffeaeaea),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: .5, color: kPrimaryColor)))),
        home: const SplashScreen(),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
