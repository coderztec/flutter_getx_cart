
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_getx_cart/model/cart_model.dart';
import 'package:flutter_getx_cart/model/product_model.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

const myCartKey='Cart';

Future<List<ProductModel>> readJsonDatabase() async{
  final rawData=await rootBundle.loadString("assets/data/my_product_json.json");
  final list=json.decode(rawData) as List<dynamic>;
  return list.map((e) => ProductModel.fromJson(e)).toList();

}
bool isExistInCart(RxList<CartModel>cart,CartModel cartItem){
  return cart.contains(cartItem);
}