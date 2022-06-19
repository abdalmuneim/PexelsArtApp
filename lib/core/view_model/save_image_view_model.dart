import 'dart:io' as io;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class SaveImageViewModel extends ChangeNotifier {
  save(context, String url, {int quality = 60, required String name}) async {
    await PermissionChecker().askPermission();
    io.Directory? dir = await getExternalStorageDirectory();
    try {
      Dio dio = Dio();
      ProgressDialog pd = ProgressDialog(context: context);
      pd.show(max: 100, msg: 'Downloading...');
      await dio.download(url, '${dir?.path}/$name',
          onReceiveProgress: (rec, total) {
        int progress = (((rec / total) * 100).toInt());
        pd.update(value: progress);
      });
      pd.close();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Photo Saved Successful'),
      ));
    } catch (e) {
      print('ERROR--> $e');
    }
  }
}

class PermissionChecker {
  late Future<int> storagePermissionChecker;

  /// asking permission
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

  /// saving image to gallery function
// save(context, url) async {
//   if (io.Platform.isAndroid) {
//     await askPermission();
//   }
//   CustomerPOP().popDialog(context,
//       title: CustomerImageNetWork(url: url), desc: 'Downloading...');
//
//   ///TODO: api Download
//
//   // final response = DownloadApi();
//   // await response.getUint8Photo(url);
//   // final res = response.uint8list;
//   // final result = await ImageGallerySaver.saveImage(Uint8List.fromList(res));
//   // print(result);
//   // print('default path: ${result['filePath']}');
//
//   var response = await Dio()
//       .get(url, options: Options(responseType: ResponseType.bytes));
//   final result =
//       await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
//   print(result);
//   print('default path: ${result['filePath']}');
//
//   // set wallpaper to home Screen and LockScreem
//   // int lockScreenLocation = WallpaperManager.LOCK_SCREEN;
//   // int homeScreenLocation = WallpaperManager.HOME_SCREEN;
//   int bothScreenLocation = WallpaperManager.BOTH_SCREENS;
//
//   // set path image
//   final imagePath =
//       result['filePath'].toString().replaceAll(RegExp('file://'), '');
//
//   // setting wallpaper
//   String setBoth;
//   // String setLockScreen;
//   // String setHomeScreen;
//   try {
//     // setLockScreen = await WallpaperManager.setWallpaperFromFile(imagePath, lockScreenLocation);
//     // setHomeScreen = await WallpaperManager.setWallpaperFromFile(imagePath, homeScreenLocation);
//     setBoth = await WallpaperManager.setWallpaperFromFile(
//         imagePath, bothScreenLocation);
//
//     // print status to console
//     print(setBoth);
//     // print(setHomeScreen);
//
//   } on PlatformException {
//     // setLockScreen = "Failed To Set Wallpaper in LockScreen";
//     // setHomeScreen = "Failed to Set Wallpaper in HomeScreen";
//     setBoth = "Failed To Set Wallpaper in Both";
//   }
//   // if (!mounted) {
//   //   return;
//   // }
//   Navigator.pop(context);
// }
}
