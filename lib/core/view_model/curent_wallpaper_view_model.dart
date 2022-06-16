import 'package:flutter/cupertino.dart';
import 'package:pexlesart/core/api/api_services/get_curent_image.dart';
import 'package:pexlesart/models/wallpaper_model.dart';

class CurentWallpaperViewModel extends ChangeNotifier {
  late List<WallpaperModel?> _wallpaper;

  List<WallpaperModel?> get wallpaper => _wallpaper;


Future<List<WallpaperModel?>> curentPhotosProf() async {
    GetCurentPhotos model = GetCurentPhotos();
    model.getCuratedPhotos().then((value) {
      print(value);
      _wallpaper.add(value);
    print('list: $_wallpaper');
    });
    notifyListeners();
    return _wallpaper;
  }
}
