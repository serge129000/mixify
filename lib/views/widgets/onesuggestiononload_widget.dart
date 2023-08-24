import 'package:flutter/material.dart';
import 'package:mixify/utils/constants.dart';
import 'package:mixify/utils/utils.dart';
import 'package:shimmer/shimmer.dart';

class OneLoadingSuggestionWidget extends StatelessWidget {
  const OneLoadingSuggestionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...[0, 1, 3].map((e) => Padding(
              padding: const EdgeInsets.only(
                right: 10
              ),
              child: Container(
                height: 120,
                width: kSize(context).width / 3.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey[200]
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20
                  ),
                  child: Center(
                    child: LinearProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            )),
            /* Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: SizedBox(width: kSize(context).width / 3.2),
            ),
            SizedBox(width: kSize(context).width / 3.2), */
          ],
        ),
      ),
    );
  }
}
