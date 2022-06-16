import 'package:flutter/material.dart';
import 'package:pexlesart/core/api/api_services/get_curent_image.dart';
import 'package:pexlesart/ui/widgets/customerpop.dart';
import 'package:provider/provider.dart';

import '../../core/view_model/curent_wallpaper_view_model.dart';
import '../../models/wallpaper_model.dart';

class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final curentphotoPrv = Provider.of<CurentWallpaperViewModel>(context,listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
          centerTitle: true,
        ),

        // body: Center(
        //   child: GestureDetector(
        //     onTap: () async {
        //       Provider.of<CurentWallpaperViewModel>(context, listen: false)
        //           .curentPhotosProf();
        //     },
        //     child: const Text('Get'),
        //   ),
        // ),

        body: FutureBuilder<List<WallpaperModel>>(
            future:
                curentphotoPrv.curentPhotosProf(),
            builder: (_, AsyncSnapshot<List<WallpaperModel>> snapshot) {
              final data = snapshot.data;
              print('data: $data');
              if (snapshot.hasData) {
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                    ),
                    itemBuilder: (context, index) {
                      return Image.network(data![index].src.original);
                    });
              } else {
                return Center(
                  child: CustomerPOP().loadingWidget(context),
                );
              }
            }),
      ),
    );
  }
}
