import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_project/core/routing/routes.dart';
import 'package:flutter_complete_project/features/home/logic/home_cubit.dart';
import 'package:flutter_complete_project/features/home/ui/home_screen.dart';
import 'package:flutter_complete_project/features/login/logic/cubit/login_cubit.dart';
import 'package:flutter_complete_project/features/login/ui/login_screen.dart';
import 'package:flutter_complete_project/features/onboarding/onboarding_screen.dart';

import '../../features/details_screen/ui/details_screen.dart';
import '../../features/onboarding/logic/cubit/service_providers_cubit.dart';
 // Import your ServiceProviders model
import '../../features/onboarding/sevices_model.dart';
import '../../features/sign_up/logic/sign_up_cubit.dart';
import '../../features/sign_up/ui/sign_up_screen.dart';
import '../di/dependency_injection.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    // Extract arguments from RouteSettings
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ServiceProvidersCubit()..loadServiceProviders(),
            child: OnboardingScreen(),
          ),
        );

      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child:  LoginScreen(),
          ),
        );

      case Routes.DetailsScreen:
      // Expecting the argument to be of type ServiceProviders
        if (arguments is ServiceProviders) {
          return MaterialPageRoute(
            builder: (_) => DetailsScreen(serviceProvider: arguments),
          );
        }
        return _errorRoute();  // Return an error route if arguments are not of expected type

      // case Routes.signUpScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<SignupCubit>(),
      //       child: const SignupScreen(),
      //     ),
      //   );

      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => HomeCubit(getIt())..getSpecializations(),
            child: const HomeScreen(),
          ),
        );

      case Routes.checkoutScreen:
      // Example case: passing a simple argument like an int
        if (arguments is int) {
          return MaterialPageRoute(
            builder: (_) => CheckOutScreen(eventCount: arguments),
          );
        }
        return _errorRoute();

      default:
        return null;
    }
  }

  // Method to handle unknown routes or incorrect arguments
  Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("Error")),
          body: const Center(
            child: Text("Page not found or invalid arguments!"),
          ),
        );
      },
    );
  }
}
