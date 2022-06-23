import 'dart:typed_data';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import '../api/api_services/api_download.dart';

class SaveImageViewModel extends ChangeNotifier {
  late Future<int> storagePermissionChecker;

  // asking permission
  askPermission() async {
    if (io.Platform.isIOS) {
      var photosStatus = await Permission.photos.status;
      if (photosStatus.isDenied) {
        await Permission.photos.request();
        print("Photos Permission Status$photosStatus");
      }
    } else {
      var photoStatus = await Permission.photos.status;
      var storageStatus = await Permission.storage.status;
      if (storageStatus.isDenied) {
        await Permission.storage.request().then((value) {
          if (!value.isGranted) askPermission();
        });
        print("Android Storage Permission Status: $storageStatus");
      } else if (photoStatus.isDenied) {
        await Permission.photos.request().then((value) {
          if (!value.isGranted) askPermission();
        });
        print("Android Photos Permission Status: $photoStatus");
      }
      // Map<Permission, PermissionStatus> statuses = await [Permission.storage].request();
      // print(statuses[Permission.storage]);

    }
  }

  // saving image to gallery function
  save(context, url) async {
    if (io.Platform.isAndroid) {
      await askPermission();
    }

    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(max: 100, msg: 'Downloading...');

    ///TODO: api Download

    try {
      final response = DownloadApi();
      await response.getUint8Photo(url);
      final res = response.uint8list;
      final result = await ImageGallerySaver.saveImage(Uint8List.fromList(res));
      print(result);
      print('default path: ${result['filePath']}');

      pd.close();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Photo Saved Successful'),
      ));
    } on PlatformException {
      print('ERROR-->}');
    }
  }
}
