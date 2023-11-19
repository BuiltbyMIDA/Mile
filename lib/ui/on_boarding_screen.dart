import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer/constant/constant.dart';
import 'package:customer/controller/on_boarding_controller.dart';
import 'package:customer/themes/app_colors.dart';
import 'package:customer/themes/button_them.dart';
import 'package:customer/ui/auth_screen/login_screen.dart';
import 'package:customer/utils/Preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<OnBoardingController>(
      init: OnBoardingController(),
      builder: (controller) {
        return Scaffold(
            body: controller.isLoading.value
                ? Constant.loader()
                : AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    color: controller.selectedPageIndex.value == 2
                        ? const Color(0xFF367367)
                        : AppColors.background,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 62,
                              ),
                              Expanded(
                                flex: 4,
                                child: PageView.builder(
                                  controller: controller.pageController,
                                  onPageChanged: controller.selectedPageIndex,
                                  itemCount: controller.onBoardingList.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Hero(
                                          tag: 'logo',
                                          child: SizedBox(
                                            width: 156,
                                            height: 42.67,
                                            child: Image.asset(
                                              controller.selectedPageIndex
                                                          .value ==
                                                      2
                                                  ? "assets/app_logo2.png"
                                                  : "assets/app_logo.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 80,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: SizedBox(
                                            height: 251.21,
                                            child: Align(
                                              alignment: controller
                                                          .selectedPageIndex
                                                          .value ==
                                                      0
                                                  ? Alignment.centerRight
                                                  : controller.selectedPageIndex
                                                              .value ==
                                                          1
                                                      ? Alignment.centerLeft
                                                      : Alignment.center,
                                              child: Hero(
                                                tag: 'image_$index',
                                                child: Image.asset(
                                                  controller
                                                      .onBoardingList[index]
                                                      .image
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 24),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: List.generate(
                                              controller.onBoardingList.length,
                                              (index) => Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4),
                                                width: controller
                                                            .selectedPageIndex
                                                            .value ==
                                                        index
                                                    ? 30
                                                    : 10,
                                                height: 10,
                                                decoration: ShapeDecoration(
                                                  color: controller
                                                              .selectedPageIndex
                                                              .value ==
                                                          index
                                                      ? AppColors.primary
                                                      : const Color(0xFFD9D9D9),
                                                  shape: RoundedRectangleBorder(
                                                    side: const BorderSide(
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            99),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                controller
                                                    .onBoardingList[index].title
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: controller
                                                              .selectedPageIndex
                                                              .value ==
                                                          2
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 20,
                                                  fontFamily: 'Instrument Sans',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              SizedBox(
                                                width: 345,
                                                child: Text(
                                                  controller
                                                      .onBoardingList[index]
                                                      .description
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: controller
                                                                .selectedPageIndex
                                                                .value ==
                                                            2
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: 'Manrope',
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: 0.14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                    ),
                                    controller.selectedPageIndex.value != 2
                                        ? InkWell(
                                            onTap: () {
                                              controller.pageController
                                                  .jumpToPage(2);
                                            },
                                            child: Text(
                                              'skip all'.tr,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                letterSpacing: 1.5,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    ButtonThem.buildButton(
                                      context,
                                      title:
                                          controller.selectedPageIndex.value ==
                                                  2
                                              ? 'Get started'.tr
                                              : 'Next'.tr,
                                      btnRadius: 33,
                                      onPress: () {
                                        if (controller
                                                .selectedPageIndex.value ==
                                            2) {
                                          Preferences.setBoolean(
                                            Preferences.isFinishOnBoardingKey,
                                            true,
                                          );
                                          Get.offAll(const LoginScreen());
                                        } else {
                                          controller.pageController.jumpToPage(
                                            controller.selectedPageIndex.value +
                                                1,
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ));
      },
    );
  }

// BorderRadiusGeometry borderRadius(int index, int currentIndex) {
//   if (index == 0 && currentIndex == 0) {
//     return const BorderRadius.all(Radius.circular(10.0));
//   }
//   if (index == 0 && currentIndex == 1) {
//     return const BorderRadius.only(topLeft: Radius.circular(40.0), bottomLeft: Radius.circular(40.0));
//   }
//   if (index == 0 && currentIndex == 2) {
//     return const BorderRadius.only(topRight: Radius.circular(40.0), bottomRight: Radius.circular(40.0));
//   }
//   if (index == 1 && currentIndex == 1) {
//     return const BorderRadius.all(Radius.circular(10.0));
//   }
//   if (index == 1 && currentIndex == 1) {
//     return const BorderRadius.all(Radius.circular(10.0));
//   }
//   if (index == 1 && currentIndex == 2) {
//     return const BorderRadius.all(Radius.circular(10.0));
//   }
//   if (index == 2 && currentIndex == 2) {
//     return const BorderRadius.all(Radius.circular(10.0));
//   }
//   if (index == 2 && currentIndex == 0) {
//     return const BorderRadius.only(topLeft: Radius.circular(40.0), bottomLeft: Radius.circular(40.0));
//   }
//   if (index == 2 && currentIndex == 1) {
//     return const BorderRadius.only(topRight: Radius.circular(40.0), bottomRight: Radius.circular(40.0));
//   }
//   return const BorderRadius.all(Radius.circular(10.0));
// }
}
