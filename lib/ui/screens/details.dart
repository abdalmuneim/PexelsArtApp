import 'package:flutter/material.dart';
import 'package:pexlesart/ui/widgets/customerTextButton.dart';

import '../../models/wallpaper_model.dart';
import '../../size_config.dart';
import '../widgets/imagenetwork.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.data}) : super(key: key);
  final Photo data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: data.id,
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverAppBar(
              flexibleSpace: FlexibleSpaceBar(
                title: CustomerTextButton(
                  photographer: data.photographer,
                  url: data.photographerUrl,
                  fontSize: 25,
                ),
                background: CustomerImageNetWork(
                  url: data.src.original,
                ),
              ),
              centerTitle: true,
              pinned: true,
              expandedHeight: SizeConfig.screenHeight * 0.6,
            )
          ],
        ),
      ),
    );
  }
}
