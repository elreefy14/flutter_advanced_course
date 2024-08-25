import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

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
                Text(
                  '${eventModel?.date.toLocal()} | ${eventModel?.location}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  eventModel?.description ?? 'Event Description',
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
        ],
      ),
    );
  }
}


// EventsListScreen widget
class EventsListScreen extends StatelessWidget {
  final int eventCount;

  EventsListScreen({required this.eventCount});

  List<Event> _generateRandomEvents(int count) {
    final List<Event> events = [];
    final random = Random();

    for (int i = 0; i < count; i++) {
      events.add(Event(
        id: i + 1,
        title: 'Event ${i + 1}',
        description: 'This is a description for Event ${i + 1}',
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

    return Expanded(
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return EventListViewItem(eventModel: events[index]);
        },
      ),
    );
  }
}

