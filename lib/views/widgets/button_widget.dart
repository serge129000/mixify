import 'package:flutter/material.dart';
import 'package:mixify/utils/constants.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;
  final double? height;
  final double? width;
  final Color? color;
  const CustomButton({super.key, required this.child, this.onPressed, this.height, this.width, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height?? 50,
      width: double.infinity,
      child: ElevatedButton(onPressed: onPressed, style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(kPrimaryColor),
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25)
        ))
      ), child: child),
    );
  }
}
