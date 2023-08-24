//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mixify/data/models/search_model.dart';
import 'package:mixify/domain/repository/play_musique_repository_impl.dart';
import 'package:mixify/utils/constants.dart';
import 'package:mixify/utils/utils.dart';
import 'package:mixify/views/providers/audio_provider.dart';
import 'package:mixify/views/providers/music_provider.dart';
import 'package:mixify/views/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:just_audio/just_audio.dart';

class MusicListenScreen extends StatefulWidget {
  //final SearchModel searchModel;
  final List<SearchModel> currentPlaylist;
  final int initialIndex;
  const MusicListenScreen(
      {super.key,
      /* required this.searchModel */ required this.currentPlaylist,
      required this.initialIndex});

  @override
  State<MusicListenScreen> createState() => _MusicListenScreenState();
}

class _MusicListenScreenState extends State<MusicListenScreen> {
  late AudioProvider audioProvider;
  late AudioPlayer audioPlayer;
  bool? isPlaying;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  late int index;
  @override
  void initState() {
    audioProvider = context.read<AudioProvider>();
    audioPlayer = audioProvider.audioPlayer!;
    index = widget.initialIndex;
    Future.delayed(Duration.zero, () {
      context
          .read<MusicProvider>()
          .getCoverColor(cover: widget.currentPlaylist[index].cover);
      context.read<MusicProvider>().setNewIndex(newindex: index);
    });
    if (audioProvider.currentMusicCode !=
        widget.currentPlaylist[index].urlSong) {
      audioPlayer.stop();
      Future.delayed(Duration.zero, () {
        context
            .read<AudioProvider>()
            .setAudioPlayerId(newId: widget.currentPlaylist[index].urlSong);
        context
            .read<MusicProvider>()
            .streamMusique(searchModel: widget.currentPlaylist[index])
            .then((value) {
          /*   */
          context.read<AudioProvider>().setPausedState(isPaused: null);
          /* context.read<MusicProvider>().playStreamMusic(
              audioPlayer: audioPlayer,
              streamPath: Provider.of<MusicProvider>(context, listen: false)
                  .musiqueModel!
                  .path); */
          context.read<MusicProvider>().setNewIndex(newindex: index);
          context.read<AudioProvider>().setPausedState(isPaused: false);
        });
      });
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final isPaused = context.watch<AudioProvider>().isPauses;
    isPlaying = context.watch<AudioProvider>().isPlaying;
    duration =
        context.watch<AudioProvider>().duration ?? const Duration(seconds: 0);
    position =
        context.watch<AudioProvider>().position ?? const Duration(seconds: 0);
    return Scaffold(
      /* appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
          gradient: context.watch<MusicProvider>().primaryColor == Colors.lightBlue && context.watch<MusicProvider>().secondColor == Colors.lightBlue? null: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
            context.watch<MusicProvider>().primaryColor,
            context.watch<MusicProvider>().secondColor
          ])
        ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: CustomText(
          text: widget.searchModel.artiste,
          fontWeight: FontWeight.bold,
          color: kBlackColor,
          textSize: 20,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(17.0),
            child: Image.asset(
              kIconPath(iconName: "fav.png"),
              height: 10,
            ),
          )
        ],
      ), */
      body: Container(
        height: kSize(context).height,
        decoration: BoxDecoration(
            gradient: context.watch<MusicProvider>().primaryColor ==
                        Colors.lightBlue &&
                    context.watch<MusicProvider>().secondColor ==
                        Colors.lightBlue
                ? null
                : LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                        context.watch<MusicProvider>().primaryColor,
                        context.watch<MusicProvider>().secondColor
                      ])),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: /* context.watch<MusicProvider>().musiqueModel == null ||
                  context.watch<MusicProvider>().status == Status.loading
              ? Center(
                  child: Image.asset(
                    kGifPath(gifName: "visualisation_msic.gif"),
                    height: 70,
                  ),
                )
              :  */
              SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 90,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Center(
                        child: CustomText(
                          text: widget.currentPlaylist[index].artiste,
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
                          textSize: 20,
                        ),
                      ),
                      Image.asset(
                        kIconPath(iconName: "fav.png"),
                        height: 20,
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
                    ],
                  ),
                ),
                Container(
                  height: kSize(context).height / 2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image:
                              NetworkImage(widget.currentPlaylist[index].cover),
                          fit: BoxFit.cover)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CustomText(
                    text: widget.currentPlaylist[index].title,
                    fontWeight: FontWeight.bold,
                    textSize: 22,
                    textAlign: TextAlign.center,
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
                ),
                CustomText(
                  text: widget.currentPlaylist[index].artiste,
                  fontWeight: FontWeight.w500,
                  color: context
                                  .watch<MusicProvider>()
                                  .primaryColor
                                  .computeLuminance() +
                              context
                                  .watch<MusicProvider>()
                                  .secondColor
                                  .computeLuminance() >=
                          1
                      ? Colors.grey[600]
                      : kWhiteColor,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (index >= 0) {
                            setState(() {
                              index--;
                            });
                            Future.delayed(Duration.zero, () {
                              context.read<MusicProvider>().getCoverColor(
                                  cover: widget.currentPlaylist[index].cover);
                              context
                                  .read<MusicProvider>()
                                  .setNewIndex(newindex: index);
                            });
                            if (audioProvider.currentMusicCode !=
                                widget.currentPlaylist[index].urlSong) {
                              audioPlayer.stop();
                              Future.delayed(Duration.zero, () {
                                context
                                    .read<MusicProvider>()
                                    .setNewIndex(newindex: index);
                                context.read<AudioProvider>().setAudioPlayerId(
                                    newId:
                                        widget.currentPlaylist[index].urlSong);
                                context
                                    .read<MusicProvider>()
                                    .streamMusique(
                                        searchModel:
                                            widget.currentPlaylist[index])
                                    .then((value) {
                                  context
                                      .read<AudioProvider>()
                                      .setPausedState(isPaused: null);
                                  context.read<MusicProvider>().playStreamMusic(
                                      streamPath: Provider.of<MusicProvider>(
                                              context,
                                              listen: false)
                                          .musiqueModel!
                                          .path,
                                      audioPlayer: audioPlayer);
                                  context
                                      .read<AudioProvider>()
                                      .setPausedState(isPaused: false);
                                });
                              });
                            }
                          }
                        },
                        child: Image.asset(
                          kIconPath(iconName: "back.png"),
                          height: 30,
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
                      ),
                      context.watch<MusicProvider>().status == Status.loading
                          ? const CircularProgressIndicator(
                              color: kPrimaryColor,
                            )
                          : GestureDetector(
                              onTap: () {
                                if (isPlaying == false && isPaused == false ||
                                    isPaused == null) {
                                  context.read<MusicProvider>().playStreamMusic(
                                      audioPlayer: audioPlayer,
                                      streamPath: Provider.of<MusicProvider>(
                                              context,
                                              listen: false)
                                          .musiqueModel!
                                          .path);
                                  setState(() {
                                    isPlaying = true;
                                  });
                                  context.read<AudioProvider>().setPlayingState(
                                      isPlaying: isPlaying ?? false);
                                  context
                                      .read<AudioProvider>()
                                      .setPausedState(isPaused: false);
                                } else if (isPaused == true) {
                                  context.read<MusicProvider>().seekMusique(
                                      audioPlayer: audioPlayer,
                                      duration: position);
                                  audioPlayer.play();
                                  setState(() {
                                    isPlaying = true;
                                  });
                                  context
                                      .read<AudioProvider>()
                                      .setPausedState(isPaused: false);
                                } else {
                                  PlayMusiqueRepositoryImpl(
                                          audioPlayer: audioPlayer)
                                      .pauseStreamMusique();
                                  setState(() {
                                    isPlaying = false;
                                  });
                                  context
                                      .read<AudioProvider>()
                                      .setPausedState(isPaused: true);
                                }
                                context.read<AudioProvider>().setPlayingState(
                                    isPlaying: isPlaying ?? false);
                              },
                              child: Image.asset(
                                kIconPath(
                                    iconName: isPlaying == null || isPlaying!
                                        ? "pause.png"
                                        : "play.png"),
                                height: 60,
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
                            ),
                      GestureDetector(
                        onTap: () {
                          if (index < widget.currentPlaylist.length - 1) {
                            setState(() {
                              index++;
                            });
                            Future.delayed(Duration.zero, () {
                              context.read<MusicProvider>().getCoverColor(
                                  cover: widget.currentPlaylist[index].cover);
                              context
                                  .read<MusicProvider>()
                                  .setNewIndex(newindex: index);
                            });
                            if (audioProvider.currentMusicCode !=
                                widget.currentPlaylist[index].urlSong) {
                              audioPlayer.stop();
                              Future.delayed(Duration.zero, () {
                                context.read<AudioProvider>().setAudioPlayerId(
                                    newId:
                                        widget.currentPlaylist[index].urlSong);
                                context
                                    .read<MusicProvider>()
                                    .streamMusique(
                                        searchModel:
                                            widget.currentPlaylist[index])
                                    .then((value) {
                                  context
                                      .read<AudioProvider>()
                                      .setPausedState(isPaused: null);
                                  context.read<MusicProvider>().playStreamMusic(
                                      streamPath: Provider.of<MusicProvider>(
                                              context,
                                              listen: false)
                                          .musiqueModel!
                                          .path,
                                      audioPlayer: audioPlayer);
                                  context
                                      .read<AudioProvider>()
                                      .setPausedState(isPaused: false);
                                });
                              });
                            }
                          } else {
                            setState(() {
                              index = 0;
                            });
                            Future.delayed(Duration.zero, () {
                              context
                                  .read<MusicProvider>()
                                  .setNewIndex(newindex: index);
                            });
                          }
                        },
                        child: Image.asset(
                          kIconPath(iconName: "forward.png"),
                          height: 30,
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
                      )
                    ],
                  ),
                ),
                Builder(builder: (context) {
                  return Slider(
                      activeColor: kPrimaryColor,
                      inactiveColor: Colors.grey,
                      value: position.inSeconds.toDouble(),
                      max: duration.inSeconds.toDouble(),
                      min: 0,
                      onChanged: (value) {
                        final position = Duration(seconds: value.toInt());
                        context.read<MusicProvider>().seekMusique(
                            audioPlayer: audioPlayer, duration: position);
                      });
                }),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: timeFormtter(position),
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
                      CustomText(
                        text: timeFormtter(duration - position),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
