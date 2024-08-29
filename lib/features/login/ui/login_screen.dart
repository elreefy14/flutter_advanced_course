import 'package:flutter/material.dart';
import 'package:flutter_complete_project/core/helpers/extensions.dart';
import 'package:flutter_complete_project/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/routing/routes.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyHeader(
              image: "assets/icons/home_background.svg",
              textTop: "All you need",
              textBottom: "is stay at home.",
              offset: offset,
            ),

            //text choose event location
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                'choose event location :',
                style: TextStyles.font24BlackBold.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600

                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Color(0xFFE5E5E5),
                ),
              ),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset("assets/icons/maps-and-flags.svg"),
                  SizedBox(width: 20),
                  Expanded(
                    child: DropdownButton(
                      isExpanded: true,
                      underline: SizedBox(),
                      icon: SvgPicture.asset("assets/icons/dropdown.svg"),
                      value: "Indonesia",
                      items: [
                        'Indonesia',
                        'Bangladesh',
                        'United States',
                        'Japan'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Padding(
            //   padding:  EdgeInsets.symmetric(horizontal: 20.w),
            //   child: Text(
            //     'choose event type :',
            //     style: TextStyles.font24BlackBold.copyWith(
            //         fontSize: 18,
            //         fontWeight: FontWeight.w600
            //
            //     ),
            //   ),
            // ),
            SizedBox(height: 20),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 20),
            //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            //   height: 60,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(25),
            //     border: Border.all(
            //       color: Color(0xFFE5E5E5),
            //     ),
            //   ),
            //   child: Row(
            //     children: <Widget>[
            //      // SvgPicture.asset("assets/icons/maps-and-flags.svg"),
            //     //  SizedBox(width: 20),
            //       Expanded(
            //         child: DropdownButton(
            //           isExpanded: true,
            //           underline: SizedBox(),
            //           icon: SvgPicture.asset("assets/icons/dropdown.svg"),
            //           value: "scientific event",
            //           items: [
            //             'scientific event',
            //             'Social event',
            //           ].map<DropdownMenuItem<String>>((String value) {
            //             return DropdownMenuItem<String>(
            //               value: value,
            //               child: Text(value),
            //             );
            //           }).toList(),
            //           onChanged: (value) {},
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(height: 20),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 20.w),
            //   child: Container(
            //     width: double.infinity,
            //     height: 50.h,
            //     decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //         colors: [Color(0xFF3383CD), Color(0xFF11249F)],
            //         begin: Alignment.topRight,
            //         end: Alignment.bottomLeft,
            //       ),
            //       borderRadius: BorderRadius.circular(25),
            //     ),
            //     child: TextButton(
            //       onPressed: () {
            //         // Handle button press here
            //         context.pushNamed(
            //           Routes.onBoardingScreen,
            //           //
            //         );
            //       },
            //       child: Text(
            //         "Next",
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 16.sp,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

// Colors
const kBackgroundColor = Color(0xFFFEFEFE);
const kTitleTextColor = Color(0xFF303030);
const kBodyTextColor = Color(0xFF4B4B4B);
const kTextLightColor = Color(0xFF959595);
const kInfectedColor = Color(0xFFFF8748);
const kDeathColor = Color(0xFFFF4848);
const kRecovercolor = Color(0xFF36C12C);
const kPrimaryColor = Color(0xFF3382CC);
final kShadowColor = Color(0xFFB7B7B7).withOpacity(.16);
final kActiveShadowColor = Color(0xFF4056C6).withOpacity(.15);

// Text Style
const kHeadingTextStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w600,
);

const kSubTextStyle = TextStyle(fontSize: 16, color: kTextLightColor);

const kTitleTextstyle = TextStyle(
  fontSize: 18,
  color: kTitleTextColor,
  fontWeight: FontWeight.bold,
);


class Counter extends StatelessWidget {
  final int number;
  final Color color;
  final String title;
  const Counter({
   // Key key,
    required this.number,
    required this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(6),
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(.26),
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                color: color,
                width: 2,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          "$number",
          style: TextStyle(
            fontSize: 40,
            color: color,
          ),
        ),
        Text(title, style: kSubTextStyle),
      ],
    );
  }
}



class MyHeader extends StatefulWidget {
  final String image;
  final String textTop;
  final String textBottom;
  final double offset;
  const MyHeader(
      { required this.image, required this.textTop, required this.textBottom, required this.offset})
      ;

  @override
  _MyHeaderState createState() => _MyHeaderState();
}

class _MyHeaderState extends State<MyHeader> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(left: 40, top: 20, right: 20),
        height: 350,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF2C3E50), // Darker shade of blue
              Color(0xFF2980B9), // Lighter shade of blue
              //Color(0xFF0593B8), // Lighter shade of blue
              //Color(0xFF2DFFF5), // Darker shade of blue
            ],
          ),
          image: DecorationImage(
            image: AssetImage(""),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Text(
                      "           Your journey \n"
                          "to planning extraordinary\n "
                          "    events begins here\n",
                      style: TextStyles.font16WhiteMedium.copyWith(
                        fontSize: 26,
                      ),
                    ),
                  ),
                  Container(), // Placeholder container
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}










////////////////////////////////////////////////
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_complete_project/features/login/logic/cubit/login_cubit.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../core/helpers/spacing.dart';
// import '../../../core/theming/styles.dart';
// import '../../../core/widgets/app_text_button.dart';
// import 'widgets/dont_have_account_text.dart';
// import 'widgets/email_and_password.dart';
// import 'widgets/login_bloc_listener.dart';
// import 'widgets/terms_and_conditions_text.dart';
//
// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Welcome Back',
//                   style: TextStyles.font24BlueBold,
//                 ),
//                 verticalSpace(8),
//                 Text(
//                   'We\'re excited to have you back, can\'t wait to see what you\'ve been up to since you last logged in.',
//                   style: TextStyles.font14GrayRegular,
//                 ),
//                 verticalSpace(36),
//                 Column(
//                   children: [
//                     const EmailAndPassword(),
//                     verticalSpace(24),
//                     Align(
//                       alignment: AlignmentDirectional.centerEnd,
//                       child: Text(
//                         'Forgot Password?',
//                         style: TextStyles.font13BlueRegular,
//                       ),
//                     ),
//                     verticalSpace(40),
//                     AppTextButton(
//                       buttonText: "Login",
//                       textStyle: TextStyles.font16WhiteSemiBold,
//                       onPressed: () {
//                         validateThenDoLogin(context);
//                       },
//                     ),
//                     verticalSpace(16),
//                     const TermsAndConditionsText(),
//                     verticalSpace(60),
//                     const DontHaveAccountText(),
//                     const LoginBlocListener(),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void validateThenDoLogin(BuildContext context) {
//     if (context.read<LoginCubit>().formKey.currentState!.validate()) {
//       context.read<LoginCubit>().emitLoginStates();
//     }
//   }
// }
