import 'package:flutter/material.dart';
import 'package:mixify/views/widgets/text_widget.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30
            ),
            child: CustomText(text: "Favoris", textSize: 30, fontWeight: FontWeight.bold,),
          ),
          Expanded(child: Center(child: CustomText(text: "💔 Aucune musique", textSize: 30, fontWeight: FontWeight.w500,)))
        ],
      ),
    );
  }
}