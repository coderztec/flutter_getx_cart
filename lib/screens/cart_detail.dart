
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_cart/state/cart_state.dart';
import 'package:flutter_getx_cart/widgets/product_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get_storage/get_storage.dart';

class CartDetail extends StatelessWidget{

  final box=GetStorage();
  MyCartController controller=Get.find();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text("Cart"),),
      body: Obx(()=>Column(
        children: [
          Expanded(child: ListView.builder(
          itemCount: controller.cart.length,
          itemBuilder: (context,index){
            return  Slidable(child: Card(elevation: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 6.0),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 2,child: ProductImage(productModel: controller.cart[index],),),
                    Expanded(flex: 6,child: Container(
                    ),
                    )
                  ],
                ),
              ),
            ),
            );

          },
      )
          ),
        ],
      )
      )
    );
  }
}