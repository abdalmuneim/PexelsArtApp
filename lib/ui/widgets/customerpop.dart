import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pexlesart/ui/widgets/navigator.dart';
import 'package:pexlesart/ui/widgets/some_widgets.dart';

class CustomerPOP {
  loadingWidget(context) {
    return popDialog(context,
        title:
            LoadingAnimationWidget.hexagonDots(size: 30, color: Colors.black),
        desc: '');
  }

  handleErrors(BuildContext context, String desc) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Column(
                children: [
                  triExclamenation(),
                  const Divider(),
                ],
              ),
              content: Text(desc),
              actions: [
                TextButton(
                  onPressed: () => NavigatorPop(context),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ));
  }

  popDialog(context, {required Widget title, required String desc}) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: title,
            content: Text(desc),
          ));
  }
}
