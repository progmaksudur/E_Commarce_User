
import 'package:e_commerce_user/pages/check_outpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';
import '../utility/widgets/cart_iteam.dart';

class CartPage extends StatelessWidget {
  static const routeName = "cart-page";
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("My Cart"),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.clear), tooltip: "Clear Items",)
        ],
      ),

      body: Consumer<CartProvider>(
        builder: (context, provider, child) =>
            Column(
              children: [

                Expanded(child: ListView.builder(
                    itemCount: provider.cartList.length,
                    itemBuilder: (context, index) {
                      final cartModel = provider.cartList[index];
                      return CartItem(cartModel: cartModel, priceWithQuantity: provider.itemPriceWithQuantity(cartModel),
                        onIncrease: () {
                          provider.increaseQuantity(cartModel);
                        },
                        onDecrease: () {
                          provider.decreaseQuantity(cartModel);
                        },
                        onDelete: () {
                          provider.removeFromCart(cartModel.productId!);
                        },
                      );

                    }

                )),

                Padding(
                  padding: const EdgeInsets.only(left: 5,right: 5,bottom: 5),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Subtotal:", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                          Text("৳${provider.getCartSumtotal()}", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),

                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)
                                  )
                              ),
                              onPressed:
                              provider.totalItemsInCart ==0? null:
                                  (){
                                Navigator.pushNamed(context, CheckoutPage.routeName);
                              }, child:const Text("Checkout"))
                        ],
                      ),
                    ),
                  ),
                )



              ],
            ),
      ),





    );

  }
}
