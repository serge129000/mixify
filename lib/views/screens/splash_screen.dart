import 'package:flutter/material.dart';
import 'package:mixify/utils/constants.dart';
import 'package:mixify/utils/utils.dart';
import 'package:mixify/views/pages/auth/landing_page.dart';
import 'package:mixify/views/providers/audio_provider.dart';
import 'package:mixify/views/widgets/mixify_text_widget.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController linearAnimationController;
  @override
  void initState() {
    Future.delayed(
        Duration.zero, () => context.read<AudioProvider>().initAudioPlayer());
    linearAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..addListener(() {
            if (mounted) {
              setState(() {});
            }
          });
    Future.delayed(
        const Duration(seconds: 0), () => linearAnimationController.forward());
    Future.delayed(const Duration(seconds: 4),
        () => kReplaceToPage(context: context, page: const LandingPage()));
    super.initState();
  }

  @override
  void dispose() {
    linearAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const MixifyWidget(textHeight: 35, ixifyColor: kBlackColor,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
              child: LinearProgressIndicator(
                value: linearAnimationController.value,
                color: kPrimaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
