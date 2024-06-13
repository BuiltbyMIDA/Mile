import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/constant/collection_name.dart';
import 'package:driver/constant/constant.dart';
import 'package:driver/model/intercity_order_model.dart';
import 'package:driver/themes/app_colors.dart';
import 'package:driver/themes/responsive.dart';
import 'package:driver/ui/intercity_screen/pacel_details_screen.dart';
import 'package:driver/utils/DarkThemeProvider.dart';
import 'package:driver/utils/fire_store_utils.dart';
import 'package:driver/widget/location_view.dart';
import 'package:driver/widget/user_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AcceptedIntercityOrders extends StatelessWidget {
  const AcceptedIntercityOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          SizedBox(
            height: Responsive.width(8, context),
            width: Responsive.width(100, context),
          ),
          Expanded(
            child: Container(
              height: Responsive.height(100, context),
              width: Responsive.width(100, context),
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection(CollectionName.ordersIntercity).where('acceptedDriverId', arrayContains: FireStoreUtils.getCurrentUid()).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return  Text('Something went wrong'.tr);
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Constant.loader(context);
                    }
                    return snapshot.data!.docs.isEmpty
                        ?  Center(
                            child: Text("No accepted ride found".tr),
                          )
                        : ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              InterCityOrderModel orderModel = InterCityOrderModel.fromJson(snapshot.data!.docs[index].data() as Map<String, dynamic>);
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.containerBackground,
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(color: AppColors.containerBorder, width: 0.5),
                                    boxShadow:  [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              blurRadius: 8,
                                              offset: const Offset(0, 2), // changes position of shadow
                                            ),
                                          ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                    child: Column(
                                      children: [
                                        UserView(
                                          userId: orderModel.userId,
                                          amount: orderModel.offerRate,
                                          distance: orderModel.distance,
                                          distanceType: orderModel.distanceType,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(Constant.amountShow(amount:orderModel.offerRate.toString()),
                                                style: GoogleFonts.manrope(fontWeight: FontWeight.bold, fontSize: 18)),
                                            Text(" For ${orderModel.numberOfPassenger} Person".tr, style: GoogleFonts.manrope(fontWeight: FontWeight.bold, fontSize: 18)),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(color: Colors.grey.withOpacity(0.30), borderRadius: const BorderRadius.all(Radius.circular(5))),
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                                      child: Text(orderModel.paymentType.toString()),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.30), borderRadius: const BorderRadius.all(Radius.circular(5))),
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                                      child: Text(orderModel.intercityService!.name.toString()),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Visibility(
                                              visible: orderModel.intercityServiceId == "647f350983ba2",
                                              child: InkWell(
                                                  onTap: () {
                                                    Get.to(const ParcelDetailsScreen(), arguments: {
                                                      "orderModel": orderModel,
                                                    });
                                                  },
                                                  child: Text(
                                                    "View details".tr,
                                                    style: const TextStyle(
                                                  
                                                  fontFamily: 'Manrope',
                                                
                                               
                                                ),
                                                  )),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        LocationView(
                                          sourceLocation: orderModel.sourceLocationName.toString(),
                                          destinationLocation: orderModel.destinationLocationName.toString(),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
