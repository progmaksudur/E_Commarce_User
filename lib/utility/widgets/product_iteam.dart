
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/cart_model.dart';
import '../../model/product_model.dart';
import '../../pages/product_details_page.dart';
import '../../provider/cart_provider.dart';



class ProductItem extends StatefulWidget {
  final ProductModel product;
  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailsPage.routeName,
            arguments: widget.product.id);
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(

                alignment: Alignment.topRight,
                children: [
                  Container(

                    decoration: BoxDecoration(
                        color: Color(0xffEFEFEF),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    alignment: Alignment.center,
                    child: FadeInImage.assetNetwork(
                      image: widget.product.imageUrl.toString(),
                      height: 60,
                      placeholder: "assets/images/photos.png",
                      fadeInCurve: Curves.bounceInOut,
                      fadeInDuration: const Duration(seconds: 2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5,right: 5),
                    child: InkWell(

                        onTap: () {},
                        child: Icon(
                            Icons.favorite_outline,
                            size: 20,
                            color: Color(0xff666666)
                        )),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                widget.product.name.toString(),
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "৳${widget.product.salePrice}",
                    style: TextStyle(color: Color(0xff666666), fontSize: 12),
                  ),
                  Consumer<CartProvider>(
                      builder: (context, provider, child) {
                        final isInCart = provider.isInCart(widget.product.id!);
                        return  InkWell(
                            onTap: () {

                              if(isInCart){
                                provider.removeFromCart(widget.product.id!);
                              }else{
                                final cartModel = CartModel(
                                  productId: widget.product.id!,
                                  productName: widget.product.name,
                                  salePrice: widget.product.salePrice,
                                  imageUrl: widget.product.imageUrl,
                                );
                                provider.addToCart(cartModel);
                              }


                            },
                            child: Icon(
                              isInCart? Icons.remove_shopping_cart_outlined :  Icons.shopping_cart_outlined,
                              size: 20,
                              color: Theme.of(context).primaryColor,
                            ));
                      }

                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
