
import 'package:flutter_getx_cart/model/cart_model.dart';
import 'package:get/get.dart';

class MyCartController extends GetxController{
  var cart=List<CartModel>.empty(growable: true).obs;

  sumCart(){
    double result=0;
   return cart.map((e) =>double.parse(e.price)).reduce(
           (previousValue, element) => previousValue +element);
  }
  shippingFee(){
    return sumCart()*0.1;
  }
}