import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_project/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../onboarding/logic/cubit/service_providers_cubit.dart';
import '../../../../onboarding/logic/cubit/service_providers_state.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../onboarding/sevices_model.dart';

class ServiceProvidersListViewItem extends StatelessWidget {
  final ServiceProviders? serviceProviderModel;

  const ServiceProvidersListViewItem( {super.key, this.serviceProviderModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(Routes.DetailsScreen, arguments: serviceProviderModel);
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
              child: Container(
                height: 120.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      serviceProviderModel?.name ?? 'Service Provider Title',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Adjusted color for consistency
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      serviceProviderModel?.phone ?? 'No phone number available',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300,
                        color: Colors.black54, // Consistent with the DetailsScreen
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      serviceProviderModel?.description ?? 'No description available',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300,
                        color: Colors.black54, // Consistent with the DetailsScreen
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
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
