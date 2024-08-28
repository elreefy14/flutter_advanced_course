import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_project/core/helpers/extensions.dart';
import 'package:flutter_complete_project/core/routing/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../home/ui/widgets/doctors_list/events_list_view.dart';
import '../home/ui/widgets/specializations_list/specializations_bloc_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../home/ui/widgets/doctors_list/events_list_view.dart';
import '../login/ui/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, dynamic>> categoryScreens = [
    {
      'screen': LoginScreen(), // First screen: the LoginScreen
    },
    {
      'category': Category(name: 'Lieu', imageUrl: 'assets/images/lieu.png'),
      'events': 5,
    },
    {
      'category': Category(name: 'Décoration', imageUrl: 'assets/images/decoration.png'),
      'events': 5,
    },
    {
      'category': Category(name: 'Animation', imageUrl: 'assets/images/icons8-accordion-100.png'),
      'events': 5,
    },
    {
      'category': Category(name: 'Photographie', imageUrl: 'assets/images/photographie.png'),
      'events': 5,
    },
    {
      'category': Category(name: 'Habbillesment et beauté', imageUrl: 'assets/images/habbillesment.png'),
      'events': 5,
    },
    {
      'category': Category(name: 'Gestionnaire des invités', imageUrl: 'assets/images/gestionnaire.png'),
      'events': 5,
    },
    {
      'category': Category(name: 'véhicules de mariage', imageUrl: 'assets/images/vehicules.png'),
      'events': 5,
    },
  ];

  void _nextPage() {
    if (_currentIndex < categoryScreens.length - 1) {
      _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
    } else {
      // Finish onboarding or navigate to another screen
    }
  }

  void _skip() {
    // Skip to the last page or finish onboarding
    _pageController.jumpToPage(categoryScreens.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemCount: categoryScreens.length,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return categoryScreens[index]['screen'];
                  } else {
                    final categoryInfo = categoryScreens[index];
                    final category = categoryInfo['category'] as Category;
                    final eventCount = categoryInfo['events'] as int;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Choose an event for ${category.name} :',
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: EventsListScreen(
                              eventCount: eventCount,
                            ),
                          ),
                        ),

                      ],
                    );
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                categoryScreens.length,
                    (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  width: _currentIndex == index ? 12.0 : 8.0,
                  height: _currentIndex == index ? 12.0 : 8.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index ?  Color(0xFF2980B9) : Colors.grey,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_currentIndex == categoryScreens.length - 1) {
                    // Navigate to the CheckoutScreen
                    context.pushNamed(
                      Routes.checkoutScreen,
                      //
                    );
                  } else {
                    // Go to the next page
                    _nextPage();
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF2980B9), // Button background color
                  padding: EdgeInsets.symmetric(vertical: 14.0), // Adjusts the padding for a more prominent button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0), // Rounded corners
                  ),
                ),
                child: Text(
                  _currentIndex == categoryScreens.length - 1 ? 'Checkout' : 'Next',
                  style: TextStyle(
                    fontSize: 16.0,           // Font size for the button text
                    fontWeight: FontWeight.bold, // Bold text for emphasis
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}


class CategoryScreen extends StatelessWidget {
  final List<Category> categories;

  CategoryScreen({required this.categories});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(16.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return GestureDetector(
          onTap: () {
            // Handle category selection logic here
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                image: AssetImage(category.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.all(8.0),
            child: Text(
              category.name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
        );
      },
    );
  }
}
