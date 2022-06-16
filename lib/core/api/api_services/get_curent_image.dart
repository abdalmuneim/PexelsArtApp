import 'dart:convert';

import 'package:pexlesart/const.dart';
import 'package:http/http.dart' as http;

import '../../../models/wallpaper_model.dart';

class GetCurentPhotos {
  Future<List<WallpaperModel>> getCuratedPhotos() async {
    List<WallpaperModel> wallpaper = [];
    var url = Uri.parse(curentImageUrl + perPageLimit);
    print('URL: $url');
    try {
      http.Response response =
          await http.get(url, headers: {"Authorization": apiKey});

     if(response.statusCode == 200){
       final String strData = response.body;
       // print('strData: $strData');
       final jsonData = jsonDecode(strData);
       final Photos data = Photos.fromJson(jsonData);
       wallpaper = data.photos.map((e) => WallpaperModel.fromJson(e)).toList();
       // print('wallpaper: $wallpaper');
       return wallpaper;
     }else{
       print(response.statusCode);
     }
    } catch (e) {
      print(e);
    }
    return wallpaper;
  }
}
