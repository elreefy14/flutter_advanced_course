import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_project/features/onboarding/logic/cubit/service_providers_state.dart';
import '../../sevices_model.dart';

class ServiceProvidersCubit extends Cubit<ServiceProvidersState> {
  ServiceProvidersCubit() : super(ServiceProvidersState.initial());

  Future<void> loadServiceProviders() async {
    emit(ServiceProvidersState.loading());

    try {
      final jsonData = await loadJsonData();
      final List<ServiceProviders> serviceProviders = parseJson(jsonData);
      emit(ServiceProvidersState.success(serviceProviders));
    } catch (error) {
      emit(ServiceProvidersState.error(error.toString()));
    }
  }
}
Future<Map<String, dynamic>> loadJsonData() async {
  final String jsonString = await rootBundle.loadString('assets/images/service_providers.json');
  return jsonDecode(jsonString);
}