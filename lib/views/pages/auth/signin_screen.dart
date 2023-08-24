import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mixify/utils/utils.dart';
import 'package:mixify/views/pages/auth/login_screen.dart';
import 'package:mixify/views/widgets/button_widget.dart';
import 'package:mixify/views/widgets/input_widget.dart';
import 'package:mixify/views/widgets/text_widget.dart';

import '../../../utils/constants.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool obscureText = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "M",
                        style: GoogleFonts.oswald(
                            color: kPrimaryColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: "IXIFY",
                        style: GoogleFonts.oswald(
                            color: kBlackColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold))
                  ])),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Center(
                      child: CustomText(
                    text: "Inscription",
                    color: kPrimaryColor,
                    textSize: 50,
                    fontWeight: FontWeight.w500,
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: CustomText(
                    text:
                        "Inscrivez vous sur Mixify pour profiter de la musique en illimite",
                    textAlign: TextAlign.center,
                    color: Colors.grey[800],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: InputWidget(
                    placeHolder: "Nom d'utilisateur",
                    prefix: const Icon(
                      Icons.person,
                      size: 20,
                    ),
                    validator: (p0) {},
                  ),
                ),
                InputWidget(
                  placeHolder: "Email",
                  prefix: const Icon(
                    Icons.mail,
                    size: 20,
                  ),
                  validator: (p0) {},
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: InputWidget(
                    obscureText: obscureText,
                    placeHolder: "Mot de passe",
                    prefix: const Icon(
                      Icons.lock,
                      size: 20,
                    ),
                    suffix: GestureDetector(
                        onTap: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        child: obscureText == true
                            ? const Icon(
                                CommunityMaterialIcons.eye,
                                size: 15,
                              )
                            : const Icon(
                                CommunityMaterialIcons.eye_off,
                                size: 15,
                              )),
                    validator: (p0) {},
                  ),
                ),
                InputWidget(
                  obscureText: obscureText,
                  placeHolder: "Confirmer Mot de passe",
                  prefix: const Icon(
                    Icons.lock,
                    size: 20,
                  ),
                  suffix: GestureDetector(
                      onTap: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      child: obscureText == true
                          ? const Icon(
                              CommunityMaterialIcons.eye,
                              size: 15,
                            )
                          : const Icon(
                              CommunityMaterialIcons.eye_off,
                              size: 15,
                            )),
                  validator: (p0) {},
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30
                  ),
                  child: CustomButton(
                    child: const CustomText(
                      text: "Inscription",
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Center(
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Vous avez deja un compte?\n",
                                style: GoogleFonts.oswald(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: kBlackColor)),
                            TextSpan(
                                text: "Se connecter",
                                style: GoogleFonts.oswald(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: kPrimaryColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScren()));
                                  })
                          ])),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
