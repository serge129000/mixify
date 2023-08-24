import 'package:flutter/material.dart';
import 'package:mixify/utils/constants.dart';
import 'package:mixify/views/widgets/text_widget.dart';

class OneMoodWidget extends StatelessWidget {
  final bool isSelected;
  final String containerText;
  final void Function() onChange;
  const OneMoodWidget(
      {super.key, required this.isSelected, required this.containerText, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChange,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: isSelected ? kPrimaryColor : const Color(0xffeaeaea)),
        child: CustomText(
          text: containerText,
          color: isSelected? kWhiteColor: kBlackColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
