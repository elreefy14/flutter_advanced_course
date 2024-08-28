import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_complete_project/core/theming/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/theming/styles.dart';

// Event model classes
class Event {
  int id;
  String title;
  String description;
  DateTime date;
  String location;
  Organizer organizer;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.organizer,
  });
}

class Organizer {
  int id;
  String name;
  String email;
  String phone;
  String photo;

  Organizer({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.photo,
  });
}

// EventListViewItem widget
// EventListViewItem widget
class EventListViewItem extends StatelessWidget {
  final Event? eventModel;

  const EventListViewItem({super.key, this.eventModel});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  eventModel?.title ?? 'Event Title',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5.h),

                SizedBox(height: 5.h),
                Text(
                  eventModel?.description ?? 'Event Description',
                  style: TextStyles.font24BlackBold.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,

                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          //add image icon .png here
          Image.asset(
            'assets/images/cancel.png', // Replace with your actual icon path
            width: 35.w,
            height: 35.h,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}


// CheckOutScreen widget
class CheckOutScreen extends StatelessWidget {
  final int eventCount;

  CheckOutScreen({required this.eventCount});

  List<Event> _generateRandomEvents(int count) {
    final List<Event> events = [];
    final random = Random();

    for (int i = 0; i < count; i++) {
      events.add(Event(
        id: i + 1,
        title: 'Service Provider ${i + 1}',
        description: 'DZD 1200',
        date: DateTime.now().add(Duration(days: random.nextInt(30))),
        location: 'Location ${random.nextInt(100)}',
        organizer: Organizer(
          id: random.nextInt(100),
          name: 'Organizer ${random.nextInt(100)}',
          email: 'organizer${random.nextInt(100)}@mail.com',
          phone: '123-456-7890',
          photo: 'https://example.com/organizer_photo.jpg',
        ),
      ));
    }

    return events;
  }

  @override
  Widget build(BuildContext context) {
    final List<Event> events = _generateRandomEvents(eventCount);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Set app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return EventListViewItem(eventModel: events[index]);
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
        ),
      ),
    );

  }
}


