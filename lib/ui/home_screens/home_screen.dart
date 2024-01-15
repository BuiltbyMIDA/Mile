import 'package:driver/constant/constant.dart';
import 'package:driver/controller/home_controller.dart';
import 'package:driver/themes/app_colors.dart';
import 'package:driver/themes/responsive.dart';
import 'package:driver/utils/fire_store_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(
        init: HomeController(),
        dispose: (state) {
          FireStoreUtils().closeStream();
        },
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: controller.isLoading.value
                ? Constant.loader(context)
                : Column(
                    children: [
                      double.parse(controller.driverModel.value.walletAmount
                                  .toString()) >=
                              double.parse(Constant.minimumDepositToRideAccept)
                          ? SizedBox(
                              height: Responsive.width(8, context),
                              width: Responsive.width(100, context),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              child: Container(
                                  width: Responsive.width(100, context),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 14),
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFEBF5FF),
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 0.60,
                                          color: Color(0xFFD9E9FC)),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset("assets/icons/info.svg"),
                                      const SizedBox(width: 16),
                                      SizedBox(
                                        width: Responsive.width(75, context),
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: 'You need a minimum of ',
                                                style: TextStyle(
                                                  color: Color(0xFF3478DD),
                                                  fontSize: 12,
                                                  fontFamily: 'Manrope',
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 0.12,
                                                ),
                                              ),
                                              TextSpan(
                                                text: Constant.amountShow(
                                                    amount: Constant
                                                        .minimumDepositToRideAccept
                                                        .toString()),
                                                style: const TextStyle(
                                                  color: Color(0xFF3478DD),
                                                  fontSize: 12,
                                                  fontFamily: 'Manrope',
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 0.12,
                                                ),
                                              ),
                                              const TextSpan(
                                                text:
                                                    ' in your wallet to accept ride orders',
                                                style: TextStyle(
                                                  color: Color(0xFF3478DD),
                                                  fontSize: 12,
                                                  fontFamily: 'Manrope',
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 0.12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                  // Text(
                                  //     "You have to minimum ${Constant.amountShow(amount: Constant.minimumDepositToRideAccept.toString())} wallet amount to Accept Order and place a bid"

                                  //         .tr,
                                  //     style: GoogleFonts.poppins(
                                  //         color: const Color(0xFF3478DD))),
                                  ),
                            ),
                      Expanded(
                        child: Container(
                          height: Responsive.height(100, context),
                          width: Responsive.width(100, context),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: controller.widgetOptions
                                .elementAt(controller.selectedIndex.value),
                          ),
                        ),
                      ),
                    ],
                  ),
            bottomNavigationBar: BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: SvgPicture.asset(
                        controller.selectedIndex.value == 0
                            ? "assets/icons/near_me (2).svg"
                            : "assets/icons/near_me (1).svg",
                        width: 26,
                      ),
                    ),
                    label: 'Requests'.tr,
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Image.asset(
                        controller.selectedIndex.value == 1
                            ? "assets/icons/ic_accepted_active.png"
                            : "assets/icons/ic_accepted.png",
                        width: 26,
                      ),
                    ),
                    label: 'Accepted'.tr,
                  ),
                  BottomNavigationBarItem(
                    icon: badges.Badge(
                      badgeContent:
                          Text(controller.isActiveValue.value.toString()),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: SvgPicture.asset(
                          controller.selectedIndex.value == 2
                              ? "assets/icons/person_pin_circle (1).svg"
                              : "assets/icons/person_pin_circle.svg",
                          width: 26,
                        ),
                      ),
                    ),
                    label: 'Active'.tr,
                  ),
                ],
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                currentIndex: controller.selectedIndex.value,
                selectedItemColor: Colors.black,
                unselectedItemColor: const Color(0xFF8E98A8),
                selectedFontSize: 13,
                unselectedFontSize: 13,
                selectedLabelStyle: const TextStyle(
                  fontSize: 13,
                  fontFamily: 'Instrument Sans',
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.14,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 13,
                  fontFamily: 'Instrument Sans',
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.14,
                ),
                onTap: controller.onItemTapped),
          );
        });
  }
}
