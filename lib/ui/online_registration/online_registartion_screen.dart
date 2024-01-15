import 'package:driver/constant/constant.dart';
import 'package:driver/controller/online_registration_controller.dart';
import 'package:driver/model/document_model.dart';
import 'package:driver/model/driver_document_model.dart';
import 'package:driver/themes/app_colors.dart';
import 'package:driver/themes/responsive.dart';
import 'package:driver/ui/online_registration/details_upload_screen.dart';
import 'package:driver/utils/DarkThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class OnlineRegistrationScreen extends StatelessWidget {
  const OnlineRegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return GetBuilder<OnlineRegistrationController>(
        init: OnlineRegistrationController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: controller.isLoading.value
                ? Constant.loader(context)
                : Column(
                    children: [
                      SizedBox(height: Responsive.height(5, context)),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Text(
                            'Please provide all the requirements to accept rides',
                            style: TextStyle(
                              color: Color(0xFF1D2939),
                              fontSize: 14,
                              fontFamily: 'Instrument Sans',
                              fontWeight: FontWeight.w600,
                              height: 0.09,
                              letterSpacing: -0.20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Responsive.height(3, context)),
                      Expanded(
                        child: controller.isLoading.value
                            ? Constant.loader(context)
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: ListView.builder(
                                  itemCount: controller.documentList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    DocumentModel documentModel =
                                        controller.documentList[index];
                                    Documents documents = Documents();

                                    var contain = controller.driverDocumentList
                                        .where((element) =>
                                            element.documentId ==
                                            documentModel.id);
                                    if (contain.isNotEmpty) {
                                      documents = controller.driverDocumentList
                                          .firstWhere((itemToCheck) =>
                                              itemToCheck.documentId ==
                                              documentModel.id);
                                    }

                                    return InkWell(
                                      onTap: () {
                                        Get.to(const DetailsUploadScreen(),
                                            arguments: {
                                              'documentModel': documentModel
                                            });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24, vertical: 16),
                                          decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  width: 0.50,
                                                  color: Color(0xFF98A1B2)),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                documentModel.title.toString(),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily: 'Manrope',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              )),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 6),
                                                clipBehavior: Clip.antiAlias,
                                                decoration: ShapeDecoration(
                                                  color:
                                                      const Color(0xFFFFF6EA),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 6,
                                                      vertical: 6),
                                                  child: Text(
                                                    documents.verified == true
                                                        ? "Verified".tr
                                                        : "Unverified".tr,
                                                    style: const TextStyle(
                                                      color: Color(0xFFED720C),
                                                      fontSize: 10,
                                                      fontFamily: 'Aileron',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      letterSpacing: -0.20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ),
                    ],
                  ),
          );
        });
  }
}
