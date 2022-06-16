import 'package:flutter/cupertino.dart';
import 'package:pexlesart/core/api/api_services/get_curent_image.dart';
import 'package:pexlesart/models/wallpaper_model.dart';

class CurentWallpaperViewModel extends ChangeNotifier {


  late List<WallpaperModel> _wallpaper = [];

  List<WallpaperModel> get wallpaper => _wallpaper;

  Future<List<WallpaperModel>> curentPhotosProf() async {
    GetCurentPhotos model = GetCurentPhotos();
    _wallpaper = await model.getCuratedPhotos().then((value) => _wallpaper = value);
    for(WallpaperModel d in _wallpaper){
      print(d.id);
    }
    notifyListeners();
    print(_wallpaper);
    return _wallpaper;
  }
}
git init
git add .
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/abdalmuneim/PexelsArtApp.git
git push -u origin main