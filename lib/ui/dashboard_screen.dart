import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer/constant/constant.dart';
import 'package:customer/controller/dash_board_controller.dart';
import 'package:customer/model/user_model.dart';
import 'package:customer/themes/app_colors.dart';
import 'package:customer/themes/responsive.dart';
import 'package:customer/utils/DarkThemeProvider.dart';
import 'package:customer/utils/fire_store_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<DashBoardController>(
        init: DashBoardController(),
        builder: (controller) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: Padding(
                padding: controller.selectedDrawerIndex.value != 5
                    ? const EdgeInsets.only(top: 20)
                    : const EdgeInsets.only(top: 0),
                child: controller.selectedDrawerIndex.value != 5
                    ? AppBar(
                        backgroundColor: Colors.white,
                        elevation: 0.0,
                        centerTitle:
                            controller.selectedDrawerIndex.value != 0 &&
                                    controller.selectedDrawerIndex.value != 6
                                ? true
                                : false,
                        title: controller.selectedDrawerIndex.value != 0 &&
                                controller.selectedDrawerIndex.value != 6
                            ? Text(
                                controller
                                    .drawerItems[
                                        controller.selectedDrawerIndex.value]
                                    .title,
                                style: const TextStyle(
                                  color: Color(0xFF1D2939),
                                  fontSize: 20,
                                  fontFamily: 'Instrument Sans',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.20,
                                ),
                              )
                            : FutureBuilder<UserModel?>(
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
                                        return Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                controller
                                                    .selectedDrawerIndex(8);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: ClipOval(
                                                    child: SvgPicture.asset(
                                                        "assets/icons/Avatar.svg")),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            SizedBox(
                                              width: Get.width / 1.8,
                                              height: 50,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      driverModel.fullName
                                                          .toString(),
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: const Color(
                                                            0xFF1D2939),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        letterSpacing: -0.20,
                                                      )),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/icons/ic_location.svg',
                                                          color: Colors.black,
                                                          width: 16),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      SizedBox(
                                                        width: Get.width / 2.5,
                                                        child: Text(
                                                            controller
                                                                .currentLocation
                                                                .value,
                                                            // textAlign: TextAlign.center,
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color: const Color(
                                                                  0xFF64748B),
                                                              fontSize: 9,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    default:
                                      return Text('Error'.tr);
                                  }
                                }),

                        leadingWidth: 50,
                        leading: Builder(builder: (context) {
                          return InkWell(
                            onTap: () {
                              Scaffold.of(context).openDrawer();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              child: SvgPicture.asset('assets/icons/menu.svg'),
                            ),
                          );
                        }),
                        // actions: [
                        //   controller.selectedDrawerIndex.value == 0
                        //       ? FutureBuilder<UserModel?>(
                        //           future: FireStoreUtils.getUserProfile(
                        //               FireStoreUtils.getCurrentUid()),
                        //           builder: (context, snapshot) {
                        //             switch (snapshot.connectionState) {
                        //               case ConnectionState.waiting:
                        //                 return Constant.loader();
                        //               case ConnectionState.done:
                        //                 if (snapshot.hasError) {
                        //                   return Text(snapshot.error.toString());
                        //                 } else {
                        //                   UserModel driverModel = snapshot.data!;
                        //                   return Row(
                        //                     children: [
                        //                       InkWell(
                        //                         onTap: () {
                        //                           controller.selectedDrawerIndex(8);
                        //                         },
                        //                         child: Padding(
                        //                           padding: const EdgeInsets.all(10.0),
                        //                           child: ClipOval(
                        //                             child: CachedNetworkImage(
                        //                               imageUrl: driverModel.profilePic
                        //                                   .toString(),
                        //                               fit: BoxFit.cover,
                        //                               placeholder: (context, url) =>
                        //                                   Constant.loader(),
                        //                               errorWidget: (context, url,
                        //                                       error) =>
                        //                                   Image.network(
                        //                                       Constant.userPlaceHolder),
                        //                             ),
                        //                           ),
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   );
                        //                 }
                        //               default:
                        //                 return Text('Error'.tr);
                        //             }
                        //           })
                        //       : Container(),
                        // ],
                      )
                    : null,
              ),
            ),
            drawer: buildAppDrawer(context, controller),
            body: WillPopScope(
                onWillPop: controller.onWillPop,
                child: controller.isLoading.value == true
                    ? Constant.loader()
                    : controller.getDrawerItemWidget(
                        controller.selectedDrawerIndex.value)),
          );
        });
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
