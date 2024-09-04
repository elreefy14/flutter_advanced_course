import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_project/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../onboarding/logic/cubit/service_providers_cubit.dart';
import '../../../../onboarding/logic/cubit/service_providers_state.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../onboarding/sevices_model.dart';

class ServiceProvidersListViewItem extends StatelessWidget {
  final ServiceProviders serviceProviderModel;
  final bool isSelected;
  final VoidCallback onSelect;

  const ServiceProvidersListViewItem({
    Key? key,
    required this.serviceProviderModel,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        print("sdfsdfsd sdfsz");
        context.pushNamed(Routes.DetailsScreen, arguments: serviceProviderModel);

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serviceProviderModel.name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    serviceProviderModel.phone,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    serviceProviderModel.description??'no description founded',
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
            SizedBox(width: 16.w),
            InkWell(
              onTap:onSelect,
              child: Image.asset(
                isSelected ? 'assets/images/done.png' : 'assets/images/add.png',
                width: 35.w,
                height: 35.h,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
