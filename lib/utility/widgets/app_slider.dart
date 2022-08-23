import 'package:carousel_slider/carousel_slider.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/product_provider.dart';

class AppSlider extends StatelessWidget {
  const AppSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false)
        .getAllFeatureProducts();
    return Consumer<ProductProvider>(
      builder: (context, provider, child) => Column(
        children: [
          if (provider.featureProductList.isNotEmpty)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,
                ),
                CarouselSlider.builder(
                    itemCount: provider.featureProductList.length,
                    itemBuilder: (context, index, realIndex) {
                      final product = provider.featureProductList[index];
                      return Card(
                        elevation: 2,
                        color: Color(0xffEFEFEF),
                        child: Stack(
                          children: [
                            FadeInImage.assetNetwork(
                              image: product.imageUrl.toString(),
                              height: 150,
                              placeholder: "assets/images/photos.png",
                              fadeInCurve: Curves.bounceInOut,
                              fadeInDuration: const Duration(seconds: 2),
                              width: double.infinity,
                              // fit: BoxFit.fill,
                            ),
                            Positioned(
                              child: Container(
                                padding: EdgeInsets.all(4),
                                alignment: Alignment.center,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.6),
                                child: Text(
                                  product.name!,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              bottom: 0,
                              left: 0,
                              right: 0,
                            ),
                            Positioned(
                              child: Column(
                                children: [
                                  CircleAvatar(

                                    child: Text(product.category == "Camera"
                                        ? "20%"
                                        : "5% ", style: TextStyle(fontWeight: FontWeight.w500),),

                                  ),
                                  Text(
                                    "Discount",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              right: 10,
                              top: 10,
                            )
                          ],
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 150,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ))
              ],
            ),
        ],
      ),
    );
  }
}
