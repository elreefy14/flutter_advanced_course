import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_project/core/helpers/extensions.dart';
import 'package:flutter_complete_project/features/onboarding/sevices_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/routing/routes.dart';
import '../home/ui/widgets/specializations_list/specializations_bloc_builder.dart';
import '../login/ui/login_screen.dart';
import 'logic/cubit/service_providers_cubit.dart';
import 'logic/cubit/service_providers_state.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final List<ServiceProviders> selectedServiceProviders = [];

  // Updated category screens with JSON data
  final List<Map<String, dynamic>> categoryScreens = [
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
    // {
    //   'category': Category(name: 'DJ', imageUrl: 'assets/images/icons8-accordion-100.png'),
    // },
    {
      'category': Category(name: 'Habillement et beauté', imageUrl: 'assets/icons/habbillesment.png'),
    },
    {
      'category': Category(name: 'Vehicules et automobile', imageUrl: 'assets/images/vehicules.png'),
    },
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

  void _toggleSelection(ServiceProviders serviceProvider) {
    setState(() {
      if (selectedServiceProviders.contains(serviceProvider)) {
        selectedServiceProviders.remove(serviceProvider);
      } else {
        selectedServiceProviders.add(serviceProvider);
      }
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
                                    final filteredServiceProviders = serviceProviders.where((sp) {
                                      return sp.category == category.name;
                                    }).toList();

                                    return ListView.builder(
                                      itemCount: filteredServiceProviders.length,
                                      itemBuilder: (context, index) {
                                        final serviceProvider = filteredServiceProviders[index];
                                        final isSelected = selectedServiceProviders.contains(serviceProvider);
                                        return InkWell(
                                          onTap: () {
                                            context.pushNamed(Routes.DetailsScreen, arguments: serviceProvider);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: 16.h),
                                            child: Row(
                                              children: [
                                                Image.network(
                                                  serviceProvider.image ?? 'https://via.placeholder.com/110x120.png', // Use a placeholder if image URL is null
                                                  width: 110.w,
                                                  height: 120.h,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error, stackTrace) => Container(
                                                    width: 110.w,
                                                    height: 120.h,
                                                    color: Colors.grey[300],
                                                    child: Icon(Icons.error, color: Colors.red),
                                                  ),
                                                ),
                                                SizedBox(width: 16.w),
                                                Expanded(
                                                  child: Container(
                                                    height: 120.h,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          serviceProvider.name ?? 'Service Provider Title',
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        SizedBox(height: 5.h),
                                                        Text(
                                                          serviceProvider.description ?? 'No phone number available',
                                                         maxLines: 3,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontWeight: FontWeight.w300,
                                                            color: Colors.black54,

                                                          ),
                                                        ),
                                                        SizedBox(height: 10.h),
                                                        Text(
                                                          serviceProvider.price.toString()+' DZD' ,
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontWeight: FontWeight.w300,
                                                            color: Colors.black54,
                                                          ),
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 16.w),
                                                InkWell(
                                                  onTap: () {
                                                    _toggleSelection(serviceProvider);
                                                  },
                                                  child: Image.asset(
                                                    isSelected
                                                        ? 'assets/images/cancel.png' // Change the icon if selected
                                                        : 'assets/images/add.png',
                                                    width: 35.w,
                                                    height: 35.h,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child:  StepperWidget(
                  categoryScreens
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(

                    child: ElevatedButton(
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
                    width: 100.w,
                  ),
                  Container(
                    width: 100.w,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentIndex == categoryScreens.length - 1) {
                          context.pushNamed(
                            Routes.checkoutScreen,
                            arguments: selectedServiceProviders,
                          );
                        } else {
                          _nextPage();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFFFF6300),
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


class StepperWidget extends StatefulWidget {
  final categoryScreens;
  StepperWidget( this.categoryScreens);

  @override
  _StepperWidgetState createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 100, // Adjust scroll distance as per your need
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToRight() {
    _scrollController.animateTo(
      _scrollController.offset + 100, // Adjust scroll distance as per your need
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goToPage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          // Left Arrow Button
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: _scrollToLeft,
          ),

          // Scrollable List of StepperDots
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              child: Row(
                children: List.generate(
                  widget.categoryScreens.length,
                      (index) {
                    final isActive = _currentIndex == index;
                    final imageUrl = widget.categoryScreens[index]['category'] != null
                        ? widget.categoryScreens[index]['category'].imageUrl
                        : 'assets/icons/default.png';

                    return StepperDot(
                      imageUrl: imageUrl,
                      categoryName: widget.categoryScreens[index]['category'] != null
                          ? widget.categoryScreens[index]['category'].name
                          : '',
                      isActive: isActive,
                      onTap: () => _goToPage(index),
                    );
                  },
                ),
              ),
            ),
          ),

          // Right Arrow Button
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: _scrollToRight,
          ),
        ],
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
    Key? key,
    required this.imageUrl,
    required this.categoryName,
    this.isActive = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String displayName = _splitCategoryName(categoryName);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4.0), // Increased padding for larger items
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive ? Colors.blue : Colors.grey,
                width: 2.0, // Increased border width for better visibility
              ),
            ),
            child: CircleAvatar(
              radius: isActive ? 24 : 20, // Increased radius for larger size
              backgroundImage: AssetImage(imageUrl),
              backgroundColor: Colors.transparent,
            ),
          ),
          if (isActive) const SizedBox(height: 6),
          if (isActive)
            Text(
              displayName,
              style: const TextStyle(
                fontSize: 12,
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
    String firstLine = words.sublist(0, midIndex).join(' ');
    String secondLine = words.sublist(midIndex).join(' ');

    return '$firstLine\n$secondLine';
  }
}




