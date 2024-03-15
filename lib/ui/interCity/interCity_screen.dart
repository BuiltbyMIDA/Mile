import 'package:bottom_picker/bottom_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer/constant/constant.dart';
import 'package:customer/themes/app_colors.dart';
import 'package:customer/themes/button_them.dart';
import 'package:customer/themes/responsive.dart';
import 'package:customer/themes/text_field_them.dart';
import 'package:customer/ui/home_screens/payment_dailog.dart';
import 'package:customer/ui/interCity/parcel_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class InterCityScreen extends StatelessWidget {
  const InterCityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          SizedBox(
            height: Responsive.width(4, context),
            width: Responsive.width(100, context),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                            onTap: () async {},
                            child: TextFieldThem.buildTextFiled(
                              context,
                              hintText: 'From'.tr,
                              controller: TextEditingController(),
                              enable: false,
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                            onTap: () async {},
                            child: TextFieldThem.buildTextFiled(
                              context,
                              hintText: 'To'.tr,
                              controller: TextEditingController(),
                              enable: false,
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Select Option".tr,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500, letterSpacing: 1)),
                        const SizedBox(
                          height: 05,
                        ),
                        SizedBox(
                          height: Responsive.height(18, context),
                          child: ListView.builder(
                            itemCount: 1,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Obx(
                                () => InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Container(
                                      width: Responsive.width(28, context),
                                      decoration: const BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          )),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .background,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(20),
                                                )),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CachedNetworkImage(
                                                imageUrl: '',
                                                fit: BoxFit.contain,
                                                height: Responsive.height(
                                                    8, context),
                                                width: Responsive.width(
                                                    18, context),
                                                placeholder: (context, url) =>
                                                    Constant.loader(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Image.network(Constant
                                                            .userPlaceHolder),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text('name',
                                              style: GoogleFonts.poppins(
                                                  color: Colors.black)),
                                        ],
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
                        InkWell(
                            onTap: () async {
                              BottomPicker.dateTime(
                                titleStyle: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                                onSubmit: (index) {},
                                minDateTime: DateTime.now(),
                                buttonAlignement: MainAxisAlignment.center,
                                displayButtonIcon: false,
                                displaySubmitButton: true,
                                title: '',
                                buttonText: 'Confirm'.tr,
                                buttonSingleColor: AppColors.primary,
                                buttonTextStyle:
                                    const TextStyle(color: Colors.white),
                              ).show(context);
                            },
                            child: TextFieldThem.buildTextFiled(
                              context,
                              hintText: 'When'.tr,
                              controller: TextEditingController(),
                              enable: false,
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            TextFieldThem.buildTextFiled(
                              context,
                              hintText: 'Parcel weight (In Kg.)'.tr,
                              controller: TextEditingController(),
                              keyBoardType: TextInputType.number,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFieldThem.buildTextFiled(
                              context,
                              hintText: 'Parcel dimension(In ft.)'.tr,
                              controller: TextEditingController(),
                              keyBoardType: TextInputType.number,
                            ),
                            parcelImageWidget(
                              context,
                            ),
                          ],
                        ),
                        Obx(() => Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: AppColors.gray,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Center(
                                          child: RichText(
                                            text: TextSpan(
                                                text:
                                                    'Recommended Price ${Constant.amountShow(amount: '10')}. Approx time '
                                                        .tr,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black),
                                                children: [
                                                  TextSpan(
                                                      text: '. Enter your rate'
                                                          .tr,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.black))
                                                ]),
                                          ),
                                        )),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            )),
                        Visibility(
                          visible: true,
                          child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: TextFieldThem.buildTextFiledWithPrefixIcon(
                                context,
                                hintText: "Enter your offer rate".tr,
                                controller: TextEditingController(),
                                prefix: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(Constant.currencyModel!.symbol
                                      .toString()),
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldThem.buildTextFiled(
                          context,
                          hintText: 'Comments'.tr,
                          controller: TextEditingController(),
                          keyBoardType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            paymentMethodDialog(
                              context,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
                              border: Border.all(
                                  color: AppColors.textFieldBorder, width: 1),
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
                                    style: GoogleFonts.poppins(),
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
                          title: "Ride Placed".tr,
                          btnWidthRatio: Responsive.width(100, context),
                          onPress: () async {},
                        ),
                      ],
                    ),
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
