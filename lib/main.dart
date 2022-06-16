import 'package:flutter/material.dart';
import 'package:pexlesart/core/view_model/curent_wallpaper_view_model.dart';
import 'package:pexlesart/ui/screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CurentWallpaperViewModel>(
        create: (_) => CurentWallpaperViewModel(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomeScreen(),
    );
  }
}
