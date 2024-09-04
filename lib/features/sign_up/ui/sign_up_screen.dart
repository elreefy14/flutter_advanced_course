import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_complete_project/core/theming/colors.dart';
import 'package:flutter_complete_project/features/onboarding/sevices_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/theming/styles.dart';
// CheckOutScreen widget
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_complete_project/features/onboarding/sevices_model.dart';

import '../logic/checkout_cubit.dart';

class CheckOutScreen extends StatelessWidget {
  final int eventCount;
  final List<ServiceProviders> serviceProviders;

  CheckOutScreen({required this.eventCount, required this.serviceProviders});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CheckOutCubit()..loadServiceProviders(serviceProviders),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white, // Set app bar color
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<CheckOutCubit, CheckOutState>(
            builder: (context, state) {
              if (state is CheckOutLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is CheckOutError) {
                return Center(child: Text(state.message));
              }
              if (state is CheckOutLoaded) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.serviceProviders.length,
                        itemBuilder: (context, index) {
                          final serviceProvider = state.serviceProviders[index];
                          return InkWell(
                            onTap: () {
                              // Navigate to details screen if needed
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 16.h),
                              child: Row(
                                children: [
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
                                            serviceProvider.phone ?? 'No phone number available',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          SizedBox(height: 10.h),
                                          Text(
                                            serviceProvider.description ?? 'No description available',
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
                                      context.read<CheckOutCubit>().deleteServiceProvider(serviceProvider);
                                    },
                                    child: Image.asset(
                                      'assets/images/cancel.png',
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
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Visibility(
                      child: Row(
                        children: [
                          Container(
                            width: 65.w,
                            height: 65.h,
                            decoration: BoxDecoration(
                              color: Color(0xFF2980B9), // Updated color
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.done_all,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ],
                            ),
                          ),
                          20.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total",
                                style: TextStyles.font24BlackBold.copyWith(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                'DZD 2400',
                                style: TextStyles.font24BlackBold.copyWith(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 26.sp,
                                  decorationThickness: 1,
                                  color: Color(0xFF2C3E50), // Updated color
                                ),
                              ),
                            ],
                          ),
                        ],
                      ).animate().fade().slideX(
                        duration: const Duration(milliseconds: 300),
                        begin: -1,
                        curve: Curves.easeInSine,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    // Send Order Button
                    ElevatedButton(
                      onPressed: () {
                        // Handle send order logic here
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 30.w),
                        backgroundColor: Color(0xFF2980B9), // Updated color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Send Order',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ).animate().fade().slideY(
                      duration: const Duration(milliseconds: 300),
                      begin: 1,
                      curve: Curves.easeInSine,
                    ),
                  ],
                );
              }

              // Default case
              return Center(child: Text('No data available'));
            },
          ),
        ),
      ),
    );
  }
}



