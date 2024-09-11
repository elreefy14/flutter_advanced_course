import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../onboarding/sevices_model.dart';
import 'components/order_button.dart';
import 'components/title_price_rating.dart';

const kPrimaryColor = Color(0xFFFF6300);
const kSecondaryColor = Color(0xFFB5BFD0);
const kTextColor = Color(0xFF50505D);
const kTextLightColor = Color(0xFF6A727D);

class DetailsScreen extends StatelessWidget {
  final ServiceProviders serviceProvider;
  final CarouselController _controller = CarouselController();
  DetailsScreen({super.key, required this.serviceProvider});
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
              itemCount: 1, // Placeholder image count
              itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                  InkWell(
                    child: SizedBox(
                      width: width,
                      child: Image.network(
                        serviceProvider.image!, // Placeholder image
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
        // Service Provider Information
        Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        TitlePriceRating(
          price :serviceProvider.price!,
          name: serviceProvider.name,
          numOfReviews: 24, // Dummy value for reviews
          rating: 4.5, // Dummy value for rating
          onRatingChanged: (value) {
          },
        ),
        SizedBox(height: 10),
        Text(
          serviceProvider.description ?? 'No description available for this service provider.',
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
              "Unknown Location", // Dummy value for location
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
                          // Add to cart or contact action
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

