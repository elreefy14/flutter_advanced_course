import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_project/features/onboarding/logic/cubit/service_providers_state.dart';

class ServiceProviders {
  final String category;
  final String subCategory;
  final String name;
  final String phone;
  final String? capacity; // Made optional
  final String? parking;  // Made optional
  final String? description; // Made optional

  ServiceProviders({
    required this.category,
    required this.subCategory,
    required this.name,
    required this.phone,
    this.capacity,
    this.parking,
    this.description,
  });

  factory ServiceProviders.fromJson(String category, String subCategory, Map<String, dynamic> json) {
    return ServiceProviders(
      category: category,
      subCategory: subCategory,
      name: json['name'],
      phone: json['phone'],
      capacity: json['capacity'], // Safely accessed
      parking: json['parking'],   // Safely accessed
      description: json['description'], // Safely accessed
    );
  }
}

class Organizer {
  final String name;
  final String email;
  final String phone;
  final String photo;

  Organizer({
    required this.name,
    required this.email,
    required this.phone,
    required this.photo,
  });

  factory Organizer.fromJson(Map<String, dynamic> json) {
    return Organizer(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      photo: json['photo'],
    );
  }
}

List<ServiceProviders> parseJson(Map<String, dynamic> jsonData) {
  final List<ServiceProviders> serviceProviders = [];

  jsonData.forEach((category, subCategories) {
    subCategories.forEach((subCategory, providers) {
      providers.forEach((provider) {
        serviceProviders.add(
          ServiceProviders.fromJson(
            category,
            subCategory,
            provider,
          ),
        );
      });
    });
  });

  return serviceProviders;
}