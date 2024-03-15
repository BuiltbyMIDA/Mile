import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

parcelImageWidget(
  BuildContext context,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
    child: SizedBox(
      height: 100,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ListView.builder(
              itemCount: 1,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    width: 100,
                    height: 100.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover, image: FileImage(File(''))),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.remove_circle,
                          size: 30,
                        )),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                onTap: () {
                  _onCameraClick(context);
                },
                child: Image.asset(
                  'assets/images/parcel_add_image.png',
                  height: 100,
                  width: 100,
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

_onCameraClick(
  BuildContext context,
) {
  final action = CupertinoActionSheet(
    message: Text(
      'Add your parcel image.'.tr,
      style: const TextStyle(fontSize: 15.0),
    ),
    actions: <Widget>[
      CupertinoActionSheetAction(
        isDefaultAction: false,
        onPressed: () async {
          Get.back();
          await ImagePicker().pickMultiImage().then((value) {
            // ignore: unused_local_variable
            for (var element in value) {}
          });
        },
        child: Text('Choose image from gallery'.tr),
      ),
      CupertinoActionSheetAction(
        isDestructiveAction: false,
        onPressed: () async {
          Get.back();
          final XFile? photo =
              await ImagePicker().pickImage(source: ImageSource.camera);
          if (photo != null) {}
        },
        child: Text('Take a picture'.tr),
      ),
    ],
    cancelButton: CupertinoActionSheetAction(
      child: Text(
        'Cancel'.tr,
      ),
      onPressed: () {
        Get.back();
      },
    ),
  );
  showCupertinoModalPopup(context: context, builder: (context) => action);
}
