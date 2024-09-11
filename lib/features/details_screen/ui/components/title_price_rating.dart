import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../../../../core/theming/styles.dart';
const kPrimaryColor = Color(0xFFFF6300);
const ksecondaryColor = Color(0xFFB5BFD0);
const kTextColor = Color(0xFF50505D);
const kTextLightColor = Color(0xFF6A727D);
class TitlePriceRating extends StatelessWidget {
  final String price;
  final int numOfReviews;
  final double rating ;
  final String name;
  final RatingChangeCallback onRatingChanged;
  const TitlePriceRating({

    required this.price,
    required this.numOfReviews,
    required this.rating,
    required this.name,
    required this.onRatingChanged,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyles.font24BlackBold,
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    SmoothStarRating(
                      color:kPrimaryColor,
                      borderColor: kPrimaryColor,
                      rating: rating,
                      onRatingChanged: onRatingChanged,
                    ),
                    SizedBox(width: 10),
                    Text("$numOfReviews reviews"),
                  ],
                ),
              ],
            ),
          ),
          priceTag(context, price: price),
        ],
      ),
    );
  }

  ClipPath priceTag(BuildContext context, {required String price}) {
    return ClipPath(
      clipper: PricerCliper(),
      child: Container(
        //alignment: Alignment.topCenter,
        padding: EdgeInsets.symmetric(vertical: 15),
        height: 66,
        width: 65,
        color: kPrimaryColor,
        child: Center(
          child: Text(
            "\$$price",
            style:TextStyles.font18WhiteMedium
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class PricerCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double ignoreHeight = 20;
    path.lineTo(0, size.height - ignoreHeight);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, size.height - ignoreHeight);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
