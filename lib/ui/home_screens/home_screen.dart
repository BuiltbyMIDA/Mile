import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer/constant/constant.dart';
import 'package:customer/themes/button_them.dart';
import 'package:customer/themes/responsive.dart';
import 'package:customer/themes/text_field_them.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                    onTap: () async {},
                                    child: TextFieldThem
                                        .buildTextFiledWithPrefixIcon(context,
                                            prefix: SvgPicture.asset(
                                                "assets/icons/near_me.svg"),
                                            hintText:
                                                'Select pickup location'.tr,
                                            controller: TextEditingController(),
                                            enable: false)),
                                SizedBox(height: Responsive.height(1, context)),
                                InkWell(
                                    onTap: () async {},
                                    child: TextFieldThem
                                        .buildTextFiledWithPrefixIcon(context,
                                            prefix: SvgPicture.asset(
                                                "assets/icons/pin_drop.svg"),
                                            hintText: 'Select destination'.tr,
                                            controller: TextEditingController(),
                                            enable: false)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 36),
                      Visibility(
                        visible: true,
                        child: SizedBox(
                            width: Get.width,
                            height: 158,
                            child: CachedNetworkImage(
                              imageUrl: '',
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: imageProvider,
                                  ),
                                ),
                              ),
                              color: Colors.black.withOpacity(0.5),
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                            )
                            // })
                            ),
                      ),
                      const SizedBox(height: 36),
                      Obx(() => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Choose a ride',
                                style: TextStyle(
                                  color: Color(0xFF1D2939),
                                  fontSize: 14,
                                  fontFamily: 'Instrument Sans',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.20,
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              SizedBox(
                                height: Responsive.height(18, context),
                                child: ListView.builder(
                                  itemCount: 1,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Obx(
                                      () => InkWell(
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Container(
                                            width:
                                                Responsive.width(28, context),
                                            height: 70,
                                            decoration: const BoxDecoration(
                                                color: Color(0x33F8E71D),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(3),
                                                )),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 8),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CachedNetworkImage(
                                                    imageUrl: ''.toString(),
                                                    fit: BoxFit.contain,
                                                    width: 112,
                                                    height: 40.77,
                                                    placeholder:
                                                        (context, url) =>
                                                            Constant.loader(),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        Image.network(Constant
                                                            .userPlaceHolder),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text('test',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xFF1D2939),
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      'Instrument Sans',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  letterSpacing:
                                                                      -0.20,
                                                                )),
                                                            const SizedBox(
                                                                height: 6),
                                                            Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const Text(
                                                                    "20 Mins",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xFF64748B),
                                                                      fontSize:
                                                                          10,
                                                                      fontFamily:
                                                                          'Manrope',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      letterSpacing:
                                                                          -0.20,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 6),
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      SvgPicture
                                                                          .asset(
                                                                              "assets/icons/supervised_user_circle.svg"),
                                                                      const SizedBox(
                                                                          width:
                                                                              4),
                                                                      const Text(
                                                                        '4 seats',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Color(0xFF64748B),
                                                                          fontSize:
                                                                              10,
                                                                          fontFamily:
                                                                              'Manrope',
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          letterSpacing:
                                                                              -0.20,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ])
                                                          ],
                                                        ),
                                                        Text(
                                                            Constant.amountShow(
                                                                amount: 'test'),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              color: Color(
                                                                  0xFF1D2939),
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'Manrope',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              height: 0.08,
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          )),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x66CBD5E1),
                                blurRadius: 0,
                                offset: Offset(0, -1),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/ic_payment.svg',
                                  width: 26,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "Select Payment type".tr,
                                  style: const TextStyle(
                                    color: Color(0xFF64748B),
                                    fontSize: 14,
                                    fontFamily: 'Manrope',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: -0.20,
                                  ),
                                )),
                                const Icon(Icons.arrow_drop_down_outlined)
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ButtonThem.buildButton(
                        context,
                        title: "Book Ride".tr,
                        btnWidthRatio: Responsive.width(100, context),
                        onPress: () async {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
