import 'package:flutter/material.dart';

class Category {
  final String name;
  final String imageUrl;

  Category({required this.name, required this.imageUrl});
}

class CategoryListView extends StatelessWidget {
  final List<Category> categories;

  const CategoryListView({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryListViewItem(category: categories[index]);
        },
      ),
    );
  }
}

class CategoryListViewItem extends StatelessWidget {
  final Category category;

  const CategoryListViewItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 24.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blue),
            ),
            child: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(category.imageUrl),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            category.name,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryScreen extends StatelessWidget {
  final List<Category> categories = [
    Category(name: 'Lieu', imageUrl: 'assets/images/lieu.png'),
    Category(name: 'Décoration', imageUrl: 'assets/images/decoration.png'),
    Category(name: 'Animation', imageUrl: 'assets/images/icons8-accordion-100.png'),
    Category(name: 'Photographie', imageUrl: 'assets/images/photographie.png'),
    Category(name: 'Habbillesment \net beauté', imageUrl: 'assets/images/habbillesment.png'),
    Category(name: 'Gestionnaire \ndes invités', imageUrl: 'assets/images/gestionnaire.png'),
    Category(name: 'véhicules \nde mariage', imageUrl: 'assets/images/vehicules.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      child: CategoryListView(categories: categories));
  }
}





// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../../core/helpers/spacing.dart';
// import '../../../logic/home_cubit.dart';
// import '../../../logic/home_state.dart';
// import '../doctors_list/doctors_shimmer_loading.dart';
// import 'speciality_list_view.dart';
// import 'speciality_shimmer_loading.dart';
//
// class SpecializationsBlocBuilder extends StatelessWidget {
//   const SpecializationsBlocBuilder({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeCubit, HomeState>(
//       buildWhen: (previous, current) =>
//           current is SpecializationsLoading ||
//           current is SpecializationsSuccess ||
//           current is SpecializationsError,
//       builder: (context, state) {
//         return state.maybeWhen(
//             specializationsLoading: () {
//               return setupLoading();
//             },
//             specializationsSuccess: (specializationDataList) {
//               var specializationsList = specializationDataList;
//               return setupSuccess(specializationsList);
//             },
//             specializationsError: (errorHandler) => setupError(),
//             orElse: () {
//               return const SizedBox.shrink();
//             });
//       },
//     );
//   }
//
//   /// shimmer loading for specializations and doctors
//   Widget setupLoading() {
//     return Expanded(
//       child: Column(
//         children: [
//           const SpecialityShimmerLoading(),
//           verticalSpace(8),
//           const DoctorsShimmerLoading(),
//         ],
//       ),
//     );
//   }
//
//   Widget setupSuccess(specializationsList) {
//     return SpecialityListView(
//       specializationDataList: specializationsList ?? [],
//     );
//   }
//
//   Widget setupError() {
//     return const SizedBox.shrink();
//   }
// }
