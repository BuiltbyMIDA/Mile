import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:driver/constant/constant.dart';
import 'package:driver/constant/show_toast_dialog.dart';
import 'package:driver/controller/details_upload_controller.dart';
import 'package:driver/themes/app_colors.dart';
import 'package:driver/themes/button_them.dart';
import 'package:driver/themes/responsive.dart';
import 'package:driver/themes/text_field_them.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class DetailsUploadScreen extends StatelessWidget {
  const DetailsUploadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<DetailsUploadController>(
        init: DetailsUploadController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                controller.documentModel.value.title.toString(),
                style: const TextStyle(
                  color: Color(0xFF1D2939),
                  fontSize: 20,
                  fontFamily: 'Instrument Sans',
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.20,
                ),
              ),
              leading: const BackButton(
                color: Colors.black,
              ),
              elevation: 0.0,
            ),
            backgroundColor: Colors.white,
            body: Column(
              children: [
                SizedBox(
                  height: Responsive.height(3, context),
                  width: Responsive.width(100, context),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Please provide your ${controller.documentModel.value.title.toString()}',
                        style: const TextStyle(
                          color: Color(0xFF1D2939),
                          fontSize: 14,
                          fontFamily: 'Instrument Sans',
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.20,
                        ),
                      )),
                ),
                Expanded(
                  child: Container(
                    child: controller.isLoading.value
                        ? Constant.loader(context)
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 20, right: 20, bottom: 5),
                                  child: TextFieldThem.buildTextFiled(context,
                                      hintText:
                                          "${controller.documentModel.value.title.toString()} Number",
                                      controller: controller
                                          .documentNumberController.value),
                                ),
                                Visibility(
                                  visible:
                                      controller.documentModel.value.expireAt ==
                                              true
                                          ? true
                                          : false,
                                  child: InkWell(
                                    onTap: () async {
                                      await Constant.selectFetureDate(context)
                                          .then((value) {
                                        if (value != null) {
                                          controller.selectedDate.value = value;
                                          controller.expireAtController.value
                                                  .text =
                                              DateFormat("dd-MM-yyyy")
                                                  .format(value);
                                        }
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 20, right: 20),
                                      child: TextFieldThem
                                          .buildTextFiledWithSuffixIcon(context,
                                              hintText: "Select Expire date".tr,
                                              controller: controller
                                                  .expireAtController.value,
                                              enable: false,
                                              suffixIcon: const Icon(
                                                  Icons.calendar_month)),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Visibility(
                                  visible: controller
                                              .documentModel.value.frontSide ==
                                          true
                                      ? true
                                      : false,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Front Side of ${controller.documentModel.value.title.toString()}"
                                              .tr,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: 'Manrope',
                                            fontWeight: FontWeight.w600,
                                            height: 0.11,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        controller.frontImage.value.isNotEmpty
                                            ? InkWell(
                                                onTap: () {
                                                  if (controller.documents.value
                                                          .verified ==
                                                      false) {
                                                    buildBottomSheet(context,
                                                        controller, "front");
                                                  }
                                                },
                                                child: SizedBox(
                                                  height: Responsive.height(
                                                      20, context),
                                                  width: Responsive.width(
                                                      90, context),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    child: Constant().hasValidUrl(
                                                                controller
                                                                    .frontImage
                                                                    .value) ==
                                                            false
                                                        ? Image.file(
                                                            File(controller
                                                                .frontImage
                                                                .value),
                                                            height: Responsive
                                                                .height(20,
                                                                    context),
                                                            width: Responsive
                                                                .width(80,
                                                                    context),
                                                            fit: BoxFit.cover,
                                                          )
                                                        : CachedNetworkImage(
                                                            imageUrl: controller
                                                                .frontImage
                                                                .value
                                                                .toString(),
                                                            fit: BoxFit.cover,
                                                            height: Responsive
                                                                .height(20,
                                                                    context),
                                                            width: Responsive
                                                                .width(80,
                                                                    context),
                                                            placeholder: (context,
                                                                    url) =>
                                                                Constant.loader(
                                                                    context),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                Image.network(
                                                                    'https://firebasestorage.googleapis.com/v0/b/goride-1a752.appspot.com/o/placeholderImages%2Fuser-placeholder.jpeg?alt=media&token=34a73d67-ba1d-4fe4-a29f-271d3e3ca115'),
                                                          ),
                                                  ),
                                                ),
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  buildBottomSheet(context,
                                                      controller, "front");
                                                },
                                                child: DottedBorder(
                                                  borderType: BorderType.RRect,
                                                  radius:
                                                      const Radius.circular(12),
                                                  dashPattern: const [
                                                    6,
                                                    6,
                                                    6,
                                                    6
                                                  ],
                                                  color:
                                                      AppColors.textFieldBorder,
                                                  child: SizedBox(
                                                      height: Responsive.height(
                                                          20, context),
                                                      width: Responsive.width(
                                                          90, context),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: SvgPicture
                                                                .asset(
                                                              'assets/icons/add_photo_alternate.svg',
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 11,
                                                          ),
                                                          const Text(
                                                            'Add the front side of your license',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF98A1B2),
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'Manrope',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              letterSpacing:
                                                                  0.12,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          const Text(
                                                            'click to upload or take picture',
                                                            style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'Manrope',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          )
                                                        ],
                                                      )),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      controller.documentModel.value.backSide ==
                                              true
                                          ? true
                                          : false,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Back side of ${controller.documentModel.value.title.toString()}"
                                              .tr,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: 'Manrope',
                                            fontWeight: FontWeight.w600,
                                            height: 0.11,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        controller.backImage.value.isNotEmpty
                                            ? InkWell(
                                                onTap: () {
                                                  if (controller.documents.value
                                                          .verified ==
                                                      false) {
                                                    buildBottomSheet(context,
                                                        controller, "back");
                                                  }
                                                },
                                                child: SizedBox(
                                                  height: Responsive.height(
                                                      20, context),
                                                  width: Responsive.width(
                                                      90, context),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    child: Constant().hasValidUrl(
                                                                controller
                                                                    .backImage
                                                                    .value) ==
                                                            false
                                                        ? Image.file(
                                                            File(controller
                                                                .backImage
                                                                .value),
                                                            height: Responsive
                                                                .height(20,
                                                                    context),
                                                            width: Responsive
                                                                .width(80,
                                                                    context),
                                                            fit: BoxFit.cover,
                                                          )
                                                        : CachedNetworkImage(
                                                            imageUrl: controller
                                                                .backImage.value
                                                                .toString(),
                                                            fit: BoxFit.cover,
                                                            height: Responsive
                                                                .height(20,
                                                                    context),
                                                            width: Responsive
                                                                .width(80,
                                                                    context),
                                                            placeholder: (context,
                                                                    url) =>
                                                                Constant.loader(
                                                                    context),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                Image.network(
                                                                    'https://firebasestorage.googleapis.com/v0/b/goride-1a752.appspot.com/o/placeholderImages%2Fuser-placeholder.jpeg?alt=media&token=34a73d67-ba1d-4fe4-a29f-271d3e3ca115'),
                                                          ),
                                                  ),
                                                ),
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  buildBottomSheet(context,
                                                      controller, "back");
                                                },
                                                child: DottedBorder(
                                                  borderType: BorderType.RRect,
                                                  radius:
                                                      const Radius.circular(12),
                                                  dashPattern: const [
                                                    6,
                                                    6,
                                                    6,
                                                    6
                                                  ],
                                                  color:
                                                      AppColors.textFieldBorder,
                                                  child: SizedBox(
                                                      height: Responsive.height(
                                                          20, context),
                                                      width: Responsive.width(
                                                          90, context),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: SvgPicture
                                                                .asset(
                                                              'assets/icons/add_photo_alternate.svg',
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 11,
                                                          ),
                                                          const Text(
                                                            'Add the front side of your license',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF98A1B2),
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'Manrope',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              letterSpacing:
                                                                  0.12,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          const Text(
                                                            'click to upload or take picture',
                                                            style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'Manrope',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          )
                                                        ],
                                                      )),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Responsive.height(30, context),
                                ),
                                Visibility(
                                  visible:
                                      controller.documents.value.verified ==
                                              true
                                          ? false
                                          : true,
                                  child: ButtonThem.buildButton(
                                    context,
                                    title: "Done".tr,
                                    onPress: () {
                                      if (controller.documentNumberController
                                          .value.text.isEmpty) {
                                        ShowToastDialog.showToast(
                                            "Please enter document number".tr);
                                      } else {
                                        if (controller.documentModel.value
                                                    .frontSide ==
                                                true &&
                                            controller
                                                .frontImage.value.isEmpty) {
                                          ShowToastDialog.showToast(
                                              "Please upload front side of document."
                                                  .tr);
                                        } else if (controller.documentModel
                                                    .value.backSide ==
                                                true &&
                                            controller
                                                .backImage.value.isEmpty) {
                                          ShowToastDialog.showToast(
                                              "Please upload back side of document."
                                                  .tr);
                                        } else {
                                          ShowToastDialog.showLoader(
                                              "Please wait..".tr);
                                          controller.uploadDocument();
                                        }
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  buildBottomSheet(
      BuildContext context, DetailsUploadController controller, String type) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return SizedBox(
              height: Responsive.height(22, context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      "Please Select".tr,
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () => controller.pickFile(
                                    source: ImageSource.camera, type: type),
                                icon: const Icon(
                                  Icons.camera_alt,
                                  size: 32,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text("Camera".tr),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () => controller.pickFile(
                                    source: ImageSource.gallery, type: type),
                                icon: const Icon(
                                  Icons.photo_library_sharp,
                                  size: 32,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text("Gallery".tr),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          });
        });
  }
}
