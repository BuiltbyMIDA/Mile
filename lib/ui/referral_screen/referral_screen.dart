import 'package:cached_network_image/cached_network_image.dart';
import 'package:clipboard/clipboard.dart';
import 'package:customer/constant/constant.dart';
import 'package:customer/constant/show_toast_dialog.dart';
import 'package:customer/controller/referral_controller.dart';
import 'package:customer/themes/app_colors.dart';
import 'package:customer/themes/button_them.dart';
import 'package:customer/themes/responsive.dart';
import 'package:customer/utils/DarkThemeProvider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../controller/dash_board_controller.dart';
import '../../model/user_model.dart';
import '../../utils/fire_store_utils.dart';

class ReferralScreen extends StatelessWidget {
  const ReferralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return GetX<ReferralController>(
        init: ReferralController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              drawer: buildAppDrawer(
                context,
                DashBoardController(),
              ),
              body: controller.isLoading.value
                  ? Constant.loader()
                  : Container(
                      child: Column(
                        children: [
                          Container(
                            height: Get.height * 0.5,
                            width: Get.width,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/bg.png'),
                                    fit: BoxFit.fill)),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 20,
                                  top: 60,
                                  child: IconButton(
                                      icon: const Icon(
                                        Icons.menu,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      onPressed: () =>
                                          Scaffold.of(context).openDrawer()),
                                ),
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 58,
                                      ),
                                      SizedBox(
                                        height: 80,
                                        child: SvgPicture.asset(
                                          'assets/images/Group 30387.svg',
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 298,
                                        child: Text(
                                          'Refer and earn',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 36,
                                            fontFamily: 'Instrument Sans',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const SizedBox(
                                        width: 279,
                                        child: Text(
                                          'Refer someone and earn \$MILE tokens when they take their first ride',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: 'Manrope',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Transform(
                            transform: Matrix4.identity()
                              ..translate(0.0, -30.0)
                              ..rotateZ(-0.095),
                            child: Container(
                              height: 70,
                              width: Get.width * 0.62,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 0),
                                child: Center(
                                  child: Text(
                                    'Earn ${Constant.referralAmount.toString()} \$MILE each',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'Instrument Sans',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          'Your referral id',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFF64748B),
                                            fontSize: 14,
                                            fontFamily: 'Manrope',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            FlutterClipboard.copy(controller
                                                    .referralModel
                                                    .value
                                                    .referralCode
                                                    .toString())
                                                .then((value) {
                                              ShowToastDialog.showToast(
                                                  "Coupon code copied".tr);
                                            });
                                          },
                                          child: SizedBox(
                                            width: 170,
                                            child: DottedBorder(
                                              borderType: BorderType.RRect,
                                              radius: const Radius.circular(8),
                                              dashPattern: const [2, 2, 2, 2],
                                              color: Colors.black,
                                              child: Container(
                                                color: Color(0xFFFAFAFA),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 16,
                                                      vertical: 6),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                        controller.referralModel
                                                            .value.referralCode
                                                            .toString(),
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 24,
                                                          fontFamily: 'Manrope',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      const Icon(Icons.copy)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      'assets/icons/ic_invite.svg',
                                                      width: 22,
                                                      color: Colors.black),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "Invite a Friend".tr,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: 'Manrope',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      'assets/icons/ic_register.svg',
                                                      width: 18,
                                                      color: Colors.black),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'They register on MILE'.tr,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: 'Manrope',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      'assets/icons/airport_shuttle.svg',
                                                      width: 22,
                                                      color:
                                                        Colors.black),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'You both earn once they take their first ride'
                                                        .tr,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: 'Manrope',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  ButtonThem.buildButton(
                                    context,
                                    title: "REFER FRIEND".tr,
                                    btnWidthRatio:
                                        Responsive.width(100, context),
                                    onPress: () async {
                                      ShowToastDialog.showLoader(
                                          "Please wait".tr);
                                      share(controller);
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
            ),
          );
        });
  }

  Future<void> share(ReferralController controller) async {
    ShowToastDialog.closeLoader();
    await FlutterShare.share(
      title: 'GoRide'.tr,
      text:
          'Hey there, thanks for choosing Mile. Hope you love our product. If you do, share it with your friends using code ${controller.referralModel.value.referralCode.toString()} and get ${Constant.amountShow(amount: Constant.referralAmount)}.'
              .tr,
    );
  }

  buildAppDrawer(BuildContext context, DashBoardController controller) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < controller.drawerItems.length; i++) {
      var d = controller.drawerItems[i];
      drawerOptions.add(InkWell(
        onTap: () {
          controller.onSelectItem(i);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            // decoration: BoxDecoration(
            //     color: i == controller.selectedDrawerIndex.value
            //         ? Theme.of(context).colorScheme.primary
            //         : Colors.transparent,
            //     borderRadius: const BorderRadius.all(Radius.circular(10))),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                SvgPicture.asset(
                  d.icon,
                  width: 20,
                  color: i == controller.drawerItems.length - 1
                      ? const Color(0xFFFF4646)
                      : AppColors.primary,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  d.title,
                  style: GoogleFonts.poppins(
                      color: i == controller.drawerItems.length - 1
                          ? const Color(0xFFFF4646)
                          : AppColors.primary,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ),
      ));
    }
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        children: [
          DrawerHeader(
            child: FutureBuilder<UserModel?>(
                future: FireStoreUtils.getUserProfile(
                    FireStoreUtils.getCurrentUid()),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Constant.loader();
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else {
                        UserModel driverModel = snapshot.data!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: CachedNetworkImage(
                                height: Responsive.width(20, context),
                                width: Responsive.width(20, context),
                                imageUrl: driverModel.profilePic.toString(),
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Constant.loader(),
                                errorWidget: (context, url, error) =>
                                    Image.network(Constant.userPlaceHolder),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                driverModel.fullName.toString(),
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 14,
                                  fontFamily: 'Instrument Sans',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.20,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                driverModel.email.toString(),
                                style: const TextStyle(
                                  color: Color(0xFFE7E7E7),
                                  fontSize: 10,
                                  fontFamily: 'Manrope',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.20,
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    default:
                      return Text('Error'.tr);
                  }
                }),
          ),
          Column(children: drawerOptions),
        ],
      ),
    );
  }
}
