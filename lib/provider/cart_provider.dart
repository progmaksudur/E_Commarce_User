
import 'package:flutter/material.dart';

import '../auth_services/auth_services.dart';
import '../database/db_helper.dart';
import '../model/cart_model.dart';



class CartProvider extends ChangeNotifier{
  List<CartModel> cartList=[];

  increaseQuantity(CartModel cartModel) async{
    await DBHelper.updateCartItemQuantity(AuthService.user!.uid, cartModel.productId!, cartModel.quantity+1);
  }

  decreaseQuantity(CartModel cartModel) async{
    if(cartModel.quantity >1){
      await DBHelper.updateCartItemQuantity(AuthService.user!.uid, cartModel.productId!, cartModel.quantity-1);
    }
  }

  num itemPriceWithQuantity(CartModel cartModel)=>
      cartModel.salePrice * cartModel.quantity;

  num getCartSumtotal(){
    num total =0;
    for(var cartModel in cartList){
      total += cartModel.salePrice * cartModel.quantity;
    }
    return total;
  }


  Future<void> addToCart(CartModel cartModel){
    return DBHelper.addToCart(AuthService.user!.uid, cartModel);
  }

  Future<void> removeFromCart(String productId){
    return DBHelper.removeFromCart(AuthService.user!.uid, productId);
  }

  getAllCartItems(){
    DBHelper.getAllCartItems(AuthService.user!.uid).listen((event) {
      cartList = List.generate(event.docs.length, (index) => CartModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });

  }


  int get totalItemsInCart  => cartList.length;

  bool isInCart(String productId){
    bool flag = false;
    for(var cart in cartList){
      if(cart.productId == productId){
        flag = true;
        break;
      }
    }
    return flag;
  }

}