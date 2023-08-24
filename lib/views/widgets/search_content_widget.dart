import 'package:flutter/material.dart';
import 'package:mixify/utils/utils.dart';
import 'package:mixify/views/pages/music_listen_screen.dart';
import 'package:mixify/views/widgets/text_widget.dart';

import '../../data/models/search_model.dart';

class SearchContent extends StatelessWidget {
  final String imagePath;
  final String title;
  final String artist;
  final List<SearchModel> allSearchs;
  final int initialIndex;
  const SearchContent(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.artist, required this.allSearchs, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return /* InkWell(
      /* onTap: kUpToPage(
          context: context,
          page: MusicListenScreen(
              currentPlaylist: allSearchs, initialIndex: initialIndex)), */
      child:  */Container(
        height: 70,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(image: NetworkImage(imagePath), fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: kSize(context).width/1.7,
                    child: CustomText(
                      isOverFlood: true,
                      text: title,
                      textSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(padding: const EdgeInsets.symmetric(
                    vertical: 5
                  ),
                  child: SizedBox(
                    width: kSize(context).width/1.9,
                    child: CustomText(text: artist, textSize: 17, isOverFlood: true,)),
                  )
                ],
              ),
            ),
          ],
        ),
     // ),
    );
  }
}
