import 'package:flutter/material.dart';
import 'package:mixify/utils/constants.dart';
import 'package:mixify/utils/utils.dart';
import 'package:mixify/views/providers/audio_provider.dart';
import 'package:mixify/views/providers/music_provider.dart';
import 'package:mixify/views/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../../data/models/search_model.dart';

class OnePlayingMusicCard extends StatefulWidget {
  final AudioProvider audioProvider;
  final List<SearchModel> musics;
  final int index;
  /*  final MusiqueModel musiqueModel; */
  const OnePlayingMusicCard({
    super.key,
    required this.audioProvider, required this.musics, required this.index,
    /*  required this.musiqueModel */
  });

  @override
  State<OnePlayingMusicCard> createState() => _OnePlayingMusicCardState();
}

class _OnePlayingMusicCardState extends State<OnePlayingMusicCard> {
  /*  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context
          .read<MusicProvider>()
          .getCoverColor(cover: widget.musiqueModel.cover);
    });
    super.initState();
  }
 */
  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors = [
      context.watch<MusicProvider>().primaryColor,
      context.watch<MusicProvider>().secondColor
    ];
    return Container(
      height: 60,
      width: kSize(context).width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topRight,
              end: Alignment.bottomLeft)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            widget.audioProvider.isPlaying == true
                ? GestureDetector(
                    onTap: () async {
                      await Provider.of<AudioProvider>(context, listen: false)
                          .audioPlayer!
                          .pause();
                    },
                    child: Icon(
                      Icons.pause,
                      color: context
                                      .watch<MusicProvider>()
                                      .primaryColor
                                      .computeLuminance() +
                                  context
                                      .watch<MusicProvider>()
                                      .secondColor
                                      .computeLuminance() >=
                              1
                          ? kBlackColor
                          : kWhiteColor,
                      size: 40,
                    ),
                  )
                : Icon(
                    Icons.play_arrow,
                    size: 40,
                    color: context
                                    .watch<MusicProvider>()
                                    .primaryColor
                                    .computeLuminance() +
                                context
                                    .watch<MusicProvider>()
                                    .secondColor
                                    .computeLuminance() >=
                            1
                        ? kBlackColor
                        : kWhiteColor,
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: kSize(context).width / 1.8,
                      child: CustomText(
                        text:
                            context.watch<MusicProvider>().musiqueModel!.title,
                        fontWeight: FontWeight.bold,
                        color: context
                                        .watch<MusicProvider>()
                                        .primaryColor
                                        .computeLuminance() +
                                    context
                                        .watch<MusicProvider>()
                                        .secondColor
                                        .computeLuminance() >=
                                1
                            ? kBlackColor
                            : kWhiteColor,
                        isOverFlood: true,
                      )),
                  CustomText(
                    text: context.watch<MusicProvider>().musiqueModel!.artist,
                    textSize: 13,
                    isOverFlood: true,
                    color: context
                                    .watch<MusicProvider>()
                                    .primaryColor
                                    .computeLuminance() +
                                context
                                    .watch<MusicProvider>()
                                    .secondColor
                                    .computeLuminance() >=
                            1
                        ? kBlackColor
                        : kWhiteColor,
                  )
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
