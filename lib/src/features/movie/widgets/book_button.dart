import 'package:flutter/material.dart';
import 'package:flutter_movie_ticket/src/core/constants/constants.dart';
import 'package:flutter_movie_ticket/src/core/data/models/movies.dart';
import 'package:flutter_movie_ticket/src/features/booking/booking_page.dart';

class BookButton extends StatelessWidget {
  const BookButton({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        const transitionDuration = Duration(milliseconds: 200);

        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: transitionDuration,
            reverseTransitionDuration: transitionDuration,
            pageBuilder: (_, animation, secondaryAnimation) {
              return FadeTransition(
                opacity: animation,
                child: BookingPage(movie: movie),
              );
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Book Now',
            style: AppTextStyles.bookButtonTextStyle.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
