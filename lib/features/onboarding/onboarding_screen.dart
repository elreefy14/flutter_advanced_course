import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_project/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/routing/routes.dart';
import '../home/ui/widgets/doctors_list/events_list_view.dart';
import '../home/ui/widgets/specializations_list/specializations_bloc_builder.dart';
import '../login/ui/login_screen.dart';
import 'logic/cubit/service_providers_cubit.dart';
import 'logic/cubit/service_providers_state.dart';
import 'sevices_model.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  // Updated category screens with JSON data
  final List<Map<String, dynamic>> categoryScreens = [
    //'screen': LoginScreen(),
    //         'category': Category(name: 'Home', imageUrl: 'assets/icons/home.png'),
    //       },
    //       {
    //         'category': Category(name: 'Lieu', imageUrl: 'assets/images/lieu.png'),
    //       },
    //       {
    //         'category': Category(name: 'Décoration', imageUrl: 'assets/images/decoration.png'),
    //       },
    //       {
    //         'category': Category(name: 'Animation', imageUrl: 'assets/images/icons8-accordion-100.png'),
    //       },
    //       {
    //         'category': Category(name: 'Photographie', imageUrl: 'assets/images/photographie.png'),
    //       },
    //       {
    //         'category': Category(name: 'Habbillesment \net beauté', imageUrl: 'assets/icons/habbillesment.png'),
    //       },
    //       {
    //         'category': Category(name: 'Gestionnaire \ndes invités', imageUrl: 'assets/icons/gestionnaire.png'),
    //       },
    //       {
    //         'category': Category(name: 'Véhicules \nde mariage', imageUrl: 'assets/images/vehicules.png'),
    //       },
    {
      'screen': LoginScreen(),
      'category': Category(name: 'Home', imageUrl: 'assets/icons/home.png'),
    },
    {
      'category': Category(name: 'Salles des fêtes', imageUrl: 'assets/images/lieu.png'),
    },
    {
      'category': Category(name: 'Catering', imageUrl: 'assets/images/icons8-kawaii-steak-100.png'),
    },
    {
      'category': Category(name: 'Photographe et vidéos', imageUrl: 'assets/images/photographie.png'),
    },
    {
      'category': Category(name: 'Décoration', imageUrl: 'assets/images/decoration.png'),
    },
    {/////////////////////////////////////////////
      'category': Category(name: 'DJ', imageUrl: 'assets/images/icons8-accordion-100.png'),
    }, {
      'category': Category(name: 'Habillement et beauté', imageUrl: 'assets/icons/habbillesment.png'),
    }, {
      'category': Category(name: 'Vehicules et automobile', imageUrl: 'assets/images/vehicules.png'),
    },
    //Habillement et beauté
    //Vehicules et automobile
    //Gestionnaire des invités

  ];

  void _nextPage() {
    if (_currentIndex < categoryScreens.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    setState(() {
      _currentIndex = index;
    });
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
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Choose a service for ${category.name}:',
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: BlocBuilder<ServiceProvidersCubit, ServiceProvidersState>(
                              builder: (context, state) {
                                return state.when(
                                  initial: () => Center(child: Text('Load service providers')),
                                  loading: () => Center(child: CircularProgressIndicator()),
                                  success: (serviceProviders) {
                                    // Filter the service providers based on the selected category
                                    final filteredServiceProviders = serviceProviders.where((sp) {
                                      return sp.category == category.name;
                                    }).toList();

                                    return ListView.builder(
                                      itemCount: filteredServiceProviders.length,
                                      itemBuilder: (context, index) {
                                        return ServiceProvidersListViewItem(serviceProviderModel:
                                           filteredServiceProviders[index],
                                        );
                                      },
                                    );
                                  },
                                  error: (error) => Center(child: Text(error)),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 20.h),
            // Custom Stepper with Icons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround, // Distribute icons evenly
                children: List.generate(
                  categoryScreens.length,
                      (index) {
                    final isActive = _currentIndex == index;
                    final imageUrl = categoryScreens[index]['category'] != null
                        ? categoryScreens[index]['category'].imageUrl
                        : 'assets/icons/default.png';

                    return StepperDot(
                      imageUrl: imageUrl,
                      categoryName: categoryScreens[index]['category'] != null
                          ? categoryScreens[index]['category'].name
                          : '',
                      isActive: isActive,
                      onTap: () => _goToPage(index),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _currentIndex == 0 ? null : _previousPage,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.grey,
                      padding: EdgeInsets.symmetric(vertical: 14.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Text(
                      'Prev',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_currentIndex == categoryScreens.length - 1) {
                        context.pushNamed(
                          Routes.checkoutScreen,
                        );
                      } else {
                        _nextPage();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFF2980B9),
                      padding: EdgeInsets.symmetric(vertical: 14.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Text(
                      _currentIndex == categoryScreens.length - 1 ? 'Checkout' : 'Next',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StepperDot extends StatelessWidget {
  final String imageUrl;
  final String categoryName;
  final bool isActive;
  final VoidCallback onTap;

  const StepperDot({
    super.key,
    required this.imageUrl,
    required this.categoryName,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String displayName = _splitCategoryName(categoryName);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive ? Colors.blue : Colors.grey,
                width: 1.0,
              ),
            ),
            child: CircleAvatar(
              radius: isActive ? 19 : 16.5,
              backgroundImage: AssetImage(imageUrl),
              backgroundColor: Colors.transparent,
            ),
          ),
          if (isActive) const SizedBox(height: 4),
          if (isActive)
            Text(
              displayName,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
              softWrap: true,
              maxLines: 2,
            ),
        ],
      ),
    );
  }

  String _splitCategoryName(String name) {
    List<String> words = name.split(' ');

    if (words.length <= 1) {
      return name;
    }

    int midIndex = (words.length / 2).ceil();
    String firstLine = words.sublist(0, 1).join(' ');
    String secondLine = words.sublist(1, 3).join(' ');

    return '$firstLine\n$secondLine';
  }
}
