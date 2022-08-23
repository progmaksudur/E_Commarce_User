
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../desgin_helper/colors_helper.dart';

class ShowLoading extends StatelessWidget {
  const ShowLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.symmetric(horizontal: 140, vertical: 15),
      child: LoadingIndicator(
          indicatorType: Indicator.ballSpinFadeLoader,
          colors: kDefaultRainbowColors,
          strokeWidth: 3,
          pathBackgroundColor: Colors.black),
    );
  }
}
