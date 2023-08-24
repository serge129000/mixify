import 'package:flutter/material.dart';
import 'package:mixify/data/models/search_model.dart';
import 'package:mixify/utils/constants.dart';
import 'package:mixify/utils/utils.dart';
import 'package:mixify/views/pages/music_listen_screen.dart';
import 'package:mixify/views/providers/music_provider.dart';
import 'package:mixify/views/providers/search_provider.dart';
import 'package:mixify/views/widgets/input_widget.dart';
import 'package:mixify/views/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../widgets/search_content_widget.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final key = GlobalKey<FormState>();
  String query = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      //height: kSize(context).height,
      child: Form(
        key: key,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: CustomText(
                  text: "Recherche",
                  textSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 20
                ),
                child: InputWidget(
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "Completer le champs";
                    }
                  },
                  placeHolder: "Artist, musique, album",
                  onChanged: (p0) {
                    query = p0;
                  },
                  suffix: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: GestureDetector(
                      onTap: () {
                        if (key.currentState!.validate()) {
                          Provider.of<SearchProvider>(context, listen: false)
                              .searchMusiques(searchQuery: query)
                              .then((value) => Provider.of<MusicProvider>(context,
                                      listen: false)
                                  .setNewPlayList(
                                      musics: Provider.of<SearchProvider>(context,
                                              listen: false)
                                          .searchResults!));
                        }
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: kPrimaryColor),
                        child: const Icon(
                          Icons.forward,
                          color: kWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (context.watch<SearchProvider>().status == Status.loading)
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: kSize(context).height / 4),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              if (context.watch<SearchProvider>().status == Status.loaded)
                SizedBox(
                  height: kSize(context).height / 1.4,
                  child: ListView.builder(
                    itemCount:
                        context.watch<SearchProvider>().searchResults!.length,
                    itemBuilder: (context, index) {
                      List<SearchModel> searchMusic =
                          context.watch<SearchProvider>().searchResults!;
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              kUpToPage(
                                  context: context,
                                  page: MusicListenScreen(
                                      currentPlaylist: searchMusic,
                                      initialIndex: index));
                            },
                            child: SearchContent(
                                imagePath: searchMusic[index].cover,
                                title: searchMusic[index].title,
                                artist: searchMusic[index].artiste,
                                allSearchs: searchMusic,
                                initialIndex: index),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      );
                    },
                  ),
                ),
              /* Column(
                  children: [
                    
                    SizedBox(
                      height: kSize(context).height/8,
                    )
                  ],
                ) */
            ],
          ),
        ),
      ),
    );
  }
}
