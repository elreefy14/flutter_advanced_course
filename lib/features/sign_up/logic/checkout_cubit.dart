import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_project/features/onboarding/sevices_model.dart'; // Adjust import as needed

// Define the Cubit states
abstract class CheckOutState {}

class CheckOutInitial extends CheckOutState {}

class CheckOutLoading extends CheckOutState {}

class CheckOutLoaded extends CheckOutState {
  final List<ServiceProviders> serviceProviders;

  CheckOutLoaded(this.serviceProviders);
}

class CheckOutError extends CheckOutState {
  final String message;

  CheckOutError(this.message);
}

// Define the Cubit
class CheckOutCubit extends Cubit<CheckOutState> {
  CheckOutCubit() : super(CheckOutInitial());

  List<ServiceProviders> _serviceProviders = [];

  void loadServiceProviders(List<ServiceProviders> providers) {
    _serviceProviders = providers;
    emit(CheckOutLoaded(_serviceProviders));
  }

  void deleteServiceProvider(ServiceProviders provider) {
    _serviceProviders.remove(provider);
    emit(CheckOutLoaded(_serviceProviders));
  }
}
