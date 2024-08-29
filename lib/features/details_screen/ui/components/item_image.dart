import 'package:flutter/material.dart';
const kPrimaryColor = Color(0xFFFFC61F);
const ksecondaryColor = Color(0xFFB5BFD0);
const kTextColor = Color(0xFF50505D);
const kTextLightColor = Color(0xFF6A727D);
class ItemImage extends StatelessWidget {
  final String imgSrc;
  const ItemImage({

    required this.imgSrc,
  }) ;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Image.asset(
      imgSrc,
      height: size.height * 0.25,
      width: double.infinity,
      // it cover the 25% of total height
      fit: BoxFit.cover,
    );
  }
}
