import 'package:flutter/material.dart';
import 'package:mixify/data/models/search_model.dart';
import 'package:mixify/utils/constants.dart';
import 'package:mixify/utils/utils.dart';
import 'package:mixify/views/pages/music_listen_screen.dart';
import 'package:mixify/views/providers/music_provider.dart';
import 'package:mixify/views/providers/search_provider.dart';
import 'package:mixify/views/widgets/artist_widget.dart';
import 'package:mixify/views/widgets/onemoodwidget.dart';
import 'package:mixify/views/widgets/onesuggestiononload_widget.dart';
import 'package:mixify/views/widgets/onesuggestrionwidget.dart';
import 'package:mixify/views/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if (Provider.of<SearchProvider>(context, listen: false).searchResults ==
          null) {
        context
            .read<SearchProvider>()
            .searchMusiques(searchQuery: "random music");
      }
    });
    super.initState();
  }

  String selection = "";
  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final hour = now.hour;
    return Container(
      height: kSize(context).height,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, right: 5, top: 30, bottom: 5),
      child: context.watch<SearchProvider>().searchResults == null
          ? Center(
              child: Image.asset(
                kGifPath(gifName: "visualisation_msic.gif"),
                height: 70,
              ),
            )
          : Builder(builder: (context) {
              Future.delayed(
                  Duration.zero,
                  () => context.read<MusicProvider>().setNewPlayList(
                      musics:
                          Provider.of<SearchProvider>(context, listen: false)
                              .searchResults!));
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: kSize(context).width / 1.5,
                            child: CustomText(
                              text: hour < 12
                                  ? "Bonjour Serge 👋"
                                  : "Bonsoir Serge 👋",
                              fontWeight: FontWeight.bold,
                              textSize: 30,
                            )),
                        Image.asset(
                          kIconPath(iconName: "notifications.png"),
                          height: 30,
                          color: kPrimaryColor,
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: CustomText(
                        text: "Mood du jour 😄🎉😍🤬💔",
                        fontWeight: FontWeight.bold,
                        textSize: 22,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...humeurs.map((e) => Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: OneMoodWidget(
                                    isSelected: selection == e,
                                    containerText: e,
                                    onChange: () {
                                      setState(() {
                                        selection = e;
                                      });
                                      context
                                          .read<SearchProvider>()
                                          .searchMusiques(
                                              searchQuery:
                                                  "musique $selection");
                                    },
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                    CustomText(
                      text: selection.isEmpty
                          ? "Titres Aleatoires"
                          : "Titres $selection",
                      fontWeight: FontWeight.bold,
                      isOverFlood: true,
                      textSize: 22,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: SizedBox(
                        height: kSize(context).height / 4.5,
                        width: double.infinity,
                        child: context.watch<SearchProvider>().status ==
                                Status.loading
                            ? OneLoadingSuggestionWidget()
                            : ListView.builder(
                                itemCount: context
                                    .watch<MusicProvider>()
                                    .currentPlaylist
                                    .length,
                                itemBuilder: (context, index) {
                                  List<SearchModel> searchMusic = context
                                      .watch<SearchProvider>()
                                      .searchResults!;
                                  return InkWell(onTap: () {
                                    kPushToPage(
                                        context: context,
                                        page: MusicListenScreen(
                                          currentPlaylist: searchMusic,
                                          initialIndex: index,
                                        ));
                                  }, child: Builder(builder: (context) {
                                    final List<SearchModel> currentPlaylist =
                                        context
                                            .watch<MusicProvider>()
                                            .currentPlaylist;
                                    return OneSuggestionWidget(
                                        imagePath: currentPlaylist[index].cover,
                                        artist: currentPlaylist[index].artiste,
                                        title: currentPlaylist[index].title);
                                  }));
                                },
                                scrollDirection: Axis.horizontal,
                              ),
                      ),
                    ),
                    /* Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...context
                                  .watch<SearchProvider>()
                                  .searchResults!
                                  .map((e) => InkWell(
                                      onTap: () {
                                        kPushToPage(
                                            context: context,
                                            page: MusicListenScreen(
                                              searchModel: e,
                                            ));
                                      },
                                      child: OneSuggestionWidget(
                                          imagePath: e.cover,
                                          artist: e.artiste,
                                          title: e.title)))
                            ]),
                      ),
                    ), */
                    const CustomText(
                      text: "Artistes",
                      fontWeight: FontWeight.bold,
                      textSize: 22,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ArtistWidget(
                              artistName: "Justin Bieber",
                              imagePath:
                                  "https://www.theplace2.ru/cache/archive/justin_bieber/img/0964_x_28329-gthumb-gwdata1200-ghdata1200-gfitdatamax.jpg",
                            ),
                            ArtistWidget(
                                artistName: "Celine Dion",
                                imagePath:
                                    "https://images5.fanpop.com/image/photos/30700000/83rd-Academy-Awards-27-02-2011-celine-dion-30784966-1667-2500.jpg"),
                            ArtistWidget(
                                artistName: "Micheal Jackson",
                                imagePath:
                                    "https://www.theplace2.ru/cache/archive/michael_jackson/img/mdzh16-gthumb-ghdata300.jpg"),
                            ArtistWidget(
                                artistName: "XXXTENTACION",
                                imagePath:
                                    "https://www.billboard.com/wp-content/uploads/media/xxxtentacion-press-photo-2018-billboard-1548.jpg")
                          ],
                        ),
                      ),
                    ),
                    const CustomText(
                      text: "Kiff du moment",
                      fontWeight: FontWeight.bold,
                      textSize: 22,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: SizedBox(
                        height: kSize(context).height / 4.5,
                        width: double.infinity,
                        child: context.watch<SearchProvider>().status ==
                                Status.loading
                            ? OneLoadingSuggestionWidget()
                            : ListView.builder(
                                itemCount: context
                                    .watch<MusicProvider>()
                                    .currentPlaylist
                                    .length,
                                itemBuilder: (context, index) {
                                  return InkWell(onTap: () {
                                    kPushToPage(
                                        context: context,
                                        page: MusicListenScreen(
                                          currentPlaylist:
                                              Provider.of<MusicProvider>(
                                                      context,
                                                      listen: false)
                                                  .currentPlaylist,
                                          initialIndex: index,
                                        ));
                                  }, child: Builder(builder: (context) {
                                    final List<SearchModel> currentPlaylist =
                                        context
                                            .watch<MusicProvider>()
                                            .currentPlaylist;
                                    return OneSuggestionWidget(
                                        imagePath: currentPlaylist[index].cover,
                                        artist: currentPlaylist[index].artiste,
                                        title: currentPlaylist[index].title);
                                  }));
                                },
                                scrollDirection: Axis.horizontal,
                              ),
                      ),
                    ),
                  ],
                ),
              );
            }),
    );
  }
}
