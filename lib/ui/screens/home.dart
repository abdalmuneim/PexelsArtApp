import 'package:flutter/material.dart';
import 'package:pexlesart/core/api/api_services/get_curent_image.dart';
import 'package:pexlesart/core/view_model/curent_wallpaper_view_model.dart';
import 'package:pexlesart/size_config.dart';
import 'package:pexlesart/ui/screens/details.dart';
import 'package:pexlesart/ui/widgets/imagenetwork.dart';
import 'package:pexlesart/ui/widgets/navigator.dart';
import 'package:provider/provider.dart';
import '../../models/wallpaper_model.dart';
import '../widgets/customerTextButton.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  late Future<WallpaperModel?> wallpaper;

  @override
  void initState() {
    wallpaper = GetCurentPhotos().getCuratedPhotos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
          centerTitle: true,
        ),
        body: FutureBuilder<WallpaperModel?>(
            future:  wallpaper,
            builder: (context, AsyncSnapshot<WallpaperModel?> snapshot) {
              if (snapshot.hasData) {
                List<Photo> data = snapshot.data!.photos;
                return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: GridView.builder(
                        itemCount: data.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          // mainAxisExtent: 10.0,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (_, index) {
                          return InkWell(
                            onTap: () => NavigatorScreen().push(context,
                                screen: DetailsScreen(
                                  data: data[index],
                                )),
                            child: Hero(
                              tag: data[index].id,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  SizedBox(
                                    width: SizeConfig.screenHeight,
                                    height: SizeConfig.screenHeight,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CustomerImageNetWork(
                                        url: data[index].src.original,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    width: SizeConfig.screenWidth,
                                    height: SizeConfig.screenHeight / 8,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: const BoxDecoration(
                                      color: Colors.black26,
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        CustomerTextButton(
                                          photographer:
                                              data[index].photographer,
                                          url: data[index].photographerUrl,
                                          fontSize: 20,
                                        ),
                                        Text(
                                          data[index].alt,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }));
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
