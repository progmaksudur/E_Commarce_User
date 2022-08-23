import 'package:flutter/cupertino.dart';

import '../database/db_helper.dart';
import '../model/order_const_model.dart';



class OrderProvider extends ChangeNotifier {
  OrderConstantsModel orderConstantsModel = OrderConstantsModel();



  Future<void> getOrderConstants() async{
    final snapshot = await DBHelper.getAllOrderConstants();
    orderConstantsModel = OrderConstantsModel.fromMap(snapshot.data()!);
    notifyListeners();
  }
}
