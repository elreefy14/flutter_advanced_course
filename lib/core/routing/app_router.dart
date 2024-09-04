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
import '../../features/sign_up/logic/sign_up_cubit.dart';
import '../../features/sign_up/ui/sign_up_screen.dart';
import '../di/dependency_injection.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingScreen ||Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ServiceProvidersCubit()..loadServiceProviders(

            ),
            child: OnboardingScreen(),
          ),
        );
      // case Routes.loginScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<LoginCubit>(),
      //       child:  OnboardingScreen(),
      //     ),
      //   );
        case Routes.DetailsScreen:
        return MaterialPageRoute(
          builder: (_) => DetailsScreen(),
        );
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
        );    case Routes.checkoutScreen:
        return MaterialPageRoute(
          builder: (_) =>  CheckOutScreen(eventCount: 2,),
        );
      default:
        return null;
    }
  }
}
