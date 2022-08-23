

import 'package:flutter/material.dart';

import '../../model/cart_model.dart';

class CartItem extends StatelessWidget {
  final CartModel cartModel;
  final num priceWithQuantity;
  final VoidCallback onIncrease, onDecrease, onDelete;
  const CartItem({
    Key? key,
    required this.cartModel,
    required this.priceWithQuantity,
    required this.onIncrease,
    required this.onDecrease,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Color(0xfffbeee9),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(0),
        clipBehavior: Clip.none,
        elevation: 3,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(

                height: 120,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor.withOpacity(0.5)
                    ),

                    color: Color(0xffEFEFEF),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))
                ),
                padding: EdgeInsets.all(10),

                child: Image.network(cartModel.imageUrl!),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  ListTile(
                    title: Text(cartModel.productName!),
                    subtitle: Text("৳${cartModel.salePrice.toString()}"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: onDecrease,
                          icon: Icon(
                            Icons.remove_circle,
                            size: 30,
                            color: Theme.of(context).primaryColor,
                          )),
                      Text(cartModel.quantity.toString(), style: TextStyle(fontWeight: FontWeight.w500),),
                      IconButton(
                          onPressed: onIncrease,
                          icon: Icon(
                            Icons.add_circle,
                            size: 30,
                            color: Theme.of(context).primaryColor,
                          )),
                    ],
                  )
                ],
              ),
            ),

            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                height: 120,
                decoration: BoxDecoration(

                  // color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10))
                ),

                child: ListTile(


                  title: FittedBox(
                    child: Text(
                      "৳${priceWithQuantity}",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ),
                  subtitle: IconButton(
                      onPressed: onDelete,
                      icon: Icon(
                        Icons.delete,
                        size: 30,
                        color: Theme.of(context).primaryColor,
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
