import 'package:flutter/material.dart';
import 'package:mixify/utils/utils.dart';
import 'package:mixify/views/widgets/text_widget.dart';

class OneSuggestionWidget extends StatelessWidget {
  final String imagePath;
  final String artist;
  final String title;
  const OneSuggestionWidget({super.key, required this.imagePath, required this.artist, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 10
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
            Container(
              height: 120,
              width: kSize(context).width / 3.2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(
                          imagePath),
                      fit: BoxFit.cover)),
            ),
            Positioned(
                bottom: 8,
                left: 8,
                child: Opacity(
                  opacity: .5,
                  child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                      child: Image.asset(
                        kIconPath(iconName: "play.png"),
                        height: 30,
                        color: Colors.white,
                      )),
                ))
          ]),
          Padding(padding: const EdgeInsets.symmetric(
            vertical: 3
          ),
          child: SizedBox(
            width: kSize(context).width/3.2,
            child: CustomText(text: artist, fontWeight: FontWeight.bold, isOverFlood: true,)),),
          SizedBox(
            width: kSize(context).width/3.2,
            child: CustomText(text: title, isOverFlood: true,),
          )
        ],
      ),
    );
  }
}
