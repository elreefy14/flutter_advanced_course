import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'components/app_bar.dart';
import 'components/body.dart';
import 'components/order_button.dart';
import 'components/title_price_rating.dart';

const kPrimaryColor = Color(0xFFFFC61F);
const kSecondaryColor = Color(0xFFB5BFD0);
const kTextColor = Color(0xFF50505D);
const kTextLightColor = Color(0xFF6A727D);

class DetailsScreen extends StatelessWidget {
  final CarouselController _controller = CarouselController();
  final product = {
    "title": "Burger chef",
    "image": "assets/images/burger.png",
    "description": "get Delicious cheese burger with fresh ingredients.",
    "farm": "MacDonalds",
    "rating": 4.0,
    "reviews": 24,
    "price": 15
  };

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: height - 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Carousel with images
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      child: CarouselSlider.builder(
                        carouselController: _controller,
                        options: CarouselOptions(
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                        ),
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                            InkWell(
                              child: SizedBox(
                                width: width,
                                child: Image.asset(
                                  product['image'].toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      ),
                    ),
                    Positioned(
                      top: 30,
                      left: 20,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),
                    Positioned(
                      top: 225,
                      left: 10,
                      right: 10,
                      child: SizedBox(
                        width: width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () => _controller.previousPage(),
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                            ),
                            InkWell(
                              onTap: () => _controller.nextPage(),
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Item information
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      TitlePriceRating(
                        name: product['title'].toString(),
                        numOfReviews: product['reviews'] as int,
                        rating: product['rating'] as double,
                        price: product['price'] as int,
                        onRatingChanged: (value) {},
                      ),
                      Text(
                        product['description'].toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: kSecondaryColor),
                          SizedBox(width: 10),
                          Text(
                            "${product['farm']}",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                // Order button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: OrderButton(
                    size: mediaQuery.size,
                    press: () {
                      // Add to cart action
                    },
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
