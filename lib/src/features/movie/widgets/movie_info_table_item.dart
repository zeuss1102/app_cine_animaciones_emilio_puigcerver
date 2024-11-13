import 'package:flutter/material.dart';
import 'package:flutter_movie_ticket/src/core/constants/constants.dart';

class MovieInfoTableItem extends StatelessWidget {
  const MovieInfoTableItem({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            title,
            style: AppTextStyles.infoTitleStyle,
            textAlign: TextAlign.left,
          ),
        ),
        Text(
          content,
          style: AppTextStyles.infoContentStyle,
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}

