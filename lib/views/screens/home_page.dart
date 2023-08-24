//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mixify/utils/constants.dart';
import 'package:mixify/utils/utils.dart';
import 'package:mixify/views/providers/audio_provider.dart';
import 'package:mixify/views/providers/music_provider.dart';
import 'package:mixify/views/providers/page_provider.dart';
import 'package:mixify/views/providers/search_provider.dart';
import 'package:mixify/views/widgets/onplayingmusic.dart';
import 'package:mixify/views/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    /* Future.delayed(Duration.zero,
        () => context.read<AudioProvider>().initAudioPlayer(/* id: "First" */)); */
    /* Future.delayed(Duration.zero, () {
       */
    Provider.of<AudioProvider>(context, listen: false)
        .audioPlayer!
        .durationStream
        .listen((event) {
      context
          .read<AudioProvider>()
          .setNewDuration(newDuration: event ?? const Duration(seconds: 0));
      /*   }); */
    });
    //
    /* Future.delayed(Duration.zero, () { */
    Provider.of<AudioProvider>(context, listen: false)
        .audioPlayer!
        .positionStream
        .listen((event) {
      context.read<AudioProvider>().setNewPosition(newPosition: event);
      if (event == Duration.zero) {
        print("finished");
        // context.read<>()
      }
      /* }); */
    });
    //
    /* Future.delayed(Duration.zero, () { */
    Provider.of<AudioProvider>(context, listen: false)
        .audioPlayer!
        .playerStateStream
        .listen((event) {
      context.read<AudioProvider>().setPlayingState(isPlaying: event.playing);
      /* }); */
    });
    super.initState();
  }

  @override
  void dispose() {
    Provider.of<AudioProvider>(context, listen: false).audioPlayer!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool? isPlaying = context.watch<AudioProvider>().isPlaying;
    return Scaffold(
      body: Stack(
        //alignment: Alignment.bottomCenter,
        children: [
          pageNameAccordingToPage[context.watch<PageProvider>().pageName]!,
          /* const SizedBox(
          height: 30,
        ), */
          isPlaying == null || isPlaying == false
              ? const SizedBox()
              : Positioned(
                  bottom: 0,
                  left: 5,
                  right: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: /* SizedBox(child: CustomText(text: context.watch<AudioProvider>().isPlaying.toString()),)//  */
                        OnePlayingMusicCard(
                            audioProvider: context.watch<
                                AudioProvider>(), index: context.watch<MusicProvider>().index, musics: context.watch<SearchProvider>().searchResults!, /* , musiqueModel: context.watch<MusicProvider>().musiqueModel!, */),
                  ),
                )
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
        height: 70,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: bottomMenuData
              .map((e) => GestureDetector(
                  onTap: () {
                    context
                        .read<PageProvider>()
                        .setNewChangePage(npageName: e["page"]);
                  },
                  child: Image.asset(
                    kIconPath(iconName: e["icon"]),
                    height: 28,
                    color: context.watch<PageProvider>().pageName == e["page"]
                        ? kPrimaryColor
                        : null,
                  )))
              .toList(),
        ),
      ),
    );
  }
}
