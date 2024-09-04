import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_project/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../onboarding/logic/cubit/service_providers_cubit.dart';
import '../../../../onboarding/logic/cubit/service_providers_state.dart';
import '../../../../onboarding/sevices_model.dart';
import '../../../../../core/routing/routes.dart';

// ServiceProvidersListViewItem widget
class ServiceProvidersListViewItem extends StatelessWidget {
  final ServiceProviders? eventModel;

  const ServiceProvidersListViewItem({super.key, this.eventModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(Routes.DetailsScreen);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        child: Row(
          children: [
            // Use AssetImage for the event image
            Image.asset(
              'assets/images/kmll.PNG',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eventModel?.name ?? 'Service Provider Title',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    '${eventModel?.description}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    eventModel?.description ?? 'Service Provider Description',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            // Add image icon .png here
            Image.asset(
              'assets/images/add.png', // Replace with your actual icon path
              width: 35.w,
              height: 35.h,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}

// ServiceProvidersListScreen widget
class ServiceProvidersListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Service Providers')),
      body: BlocBuilder<ServiceProvidersCubit, ServiceProvidersState>(
        builder: (context, state) {
          return state.when(
            initial: () => Center(child: Text('Load service providers')),
            loading: () => Center(child: CircularProgressIndicator()),
            success: (serviceProviders) => ListView.builder(
              itemCount: serviceProviders.length,
              itemBuilder: (context, index) {
                return ServiceProvidersListViewItem(eventModel: serviceProviders[index]);
              },
            ),
            error: (error) => Center(child: Text(error)),
          );
        },
      ),
    );
  }
}
