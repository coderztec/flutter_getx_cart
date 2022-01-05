
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_cart/model/cart_model.dart';
import 'package:flutter_getx_cart/model/product_model.dart';
import 'package:flutter_getx_cart/state/cart_state.dart';
import 'package:flutter_getx_cart/utils/utils.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get_storage/get_storage.dart';

//ignore:must_be_immutable
class ProductInfo extends StatelessWidget{

  ProductModel? productModel;
  ProductInfo({this.productModel});

  final controller=Get.put(MyCartController());
  final box=GetStorage();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(children: [
        Text('${productModel!.name}',style: const TextStyle(fontWeight: FontWeight.bold),),
        const SizedBox(height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(TextSpan(children: [
              TextSpan(text: double.parse(productModel!.oldPrice)==0
                  ? ''
                  : '\$${productModel!.oldPrice}',
                style: const TextStyle(color: Colors.grey ,
                decoration: TextDecoration.lineThrough
              ),),
              TextSpan(text: '\$${productModel!.price}')
            ])),
              InkWell(child: Icon(Icons.add_shopping_cart),
            onTap: ()async{
                  var cartItem=CartModel(quantity: 1 ,
                    id: productModel!.id,
                    name:productModel!.name,
                    oldPrice: productModel!.name,
                    price: productModel!.price,
                    imageUrl: productModel!.price,
                    category: productModel!.category,
                  );
                  if(isExistInCart(controller.cart,cartItem)){
                    var indexUpdate=controller.cart.indexWhere((e) => e.id ==productModel!.id);
                    var productUpdate=controller.cart.firstWhere(
                            (element) => element.id == productModel!.id);
                    productUpdate.quantity+=1;
                    controller.cart.insert(indexUpdate,productUpdate);
                  }
                 else{
                   controller.cart.add(cartItem);
                   var jsonDBEncoded=jsonEncode(controller.cart);
                   await box.write(myCartKey,jsonDBEncoded);
                   controller.cart.refresh();
                  }
            }),
          ],
        )
      ],),
    );
  }
}