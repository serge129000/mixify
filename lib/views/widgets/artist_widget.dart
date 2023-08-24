import 'package:flutter/material.dart';
import 'package:mixify/utils/utils.dart';
import 'package:mixify/views/widgets/text_widget.dart';

class ArtistWidget extends StatelessWidget {
  final String artistName;
  final String imagePath;
  const ArtistWidget({super.key, required this.artistName, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 3,
            right: 10
          ),
          child: SizedBox(
            width: kSize(context).width/3.8,
            child: CircleAvatar(
              radius: 45,
              backgroundImage: NetworkImage(imagePath),
            ),
          ),
        ),
        CustomText(text: artistName, fontWeight: FontWeight.bold,)
      ],
    );
  }
}
