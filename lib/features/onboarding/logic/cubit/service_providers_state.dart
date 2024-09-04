import 'package:flutter_complete_project/features/onboarding/sevices_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../home/ui/widgets/doctors_list/events_list_view.dart';

part 'service_providers_state.freezed.dart';

@freezed
class ServiceProvidersState with _$ServiceProvidersState {
  const factory ServiceProvidersState.initial() = _Initial;
  const factory ServiceProvidersState.loading() = _Loading;
  const factory ServiceProvidersState.success(List<ServiceProviders> serviceProviders) = _Success;
  const factory ServiceProvidersState.error(String error) = _Error;
}
