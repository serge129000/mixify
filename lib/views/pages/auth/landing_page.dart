import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mixify/utils/constants.dart';
import 'package:mixify/utils/utils.dart';
import 'package:mixify/views/pages/auth/login_screen.dart';
import 'package:mixify/views/widgets/button_widget.dart';
import 'package:mixify/views/widgets/mixify_text_widget.dart';
import 'package:mixify/views/widgets/text_widget.dart';
import 'package:video_player/video_player.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    _controller = VideoPlayerController.asset(kGifPath(gifName: "landing.mp4"));
    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SizedBox(
          height: kSize(context).height,
          width: kSize(context).width,
          /* decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(kGifPath(gifName: "landing.gif")),
                  fit: BoxFit.cover)), */
          child: VideoPlayer(_controller),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              const MixifyWidget(textHeight: 20, ixifyColor: kWhiteColor,),
              SizedBox(
                height: kSize(context).height / 1.8,
              ),
              /* Padding(padding: EdgeInsets.symmetric(
                  vertical: kSize(context).height/8
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                  Image.asset(kImagePath(imageName: "casque.png"), color: kWhiteColor,),
                  Image.asset(kGifPath(gifName: "visualisation_msic.gif"), height: 80,)
                  ]),), */
              Expanded(
                child: Opacity(
                    opacity: .8,
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 20),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          color: kBlackColor,
                        ),
                        child: Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const CustomText(
                              text:
                                  "Écoutez de la musique en illimité, créez des playlists et partagez-les facilement.",
                              textAlign: TextAlign.center,
                              color: kWhiteColor,
                              isOverFlood: false,
                              textSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CustomButton(
                                child: const CustomText(
                                  text: "Commencer",
                                  color: kWhiteColor,
                                  textSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                onPressed: () {
                                  kPushToPage(
                                      context: context,
                                      page: const LoginScren());
                                },
                              ),
                            )
                          ],
                        ))),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
