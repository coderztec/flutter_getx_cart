import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_cart/model/cart_model.dart';
import 'package:flutter_getx_cart/model/product_model.dart';
import 'package:flutter_getx_cart/screens/cart_detail.dart';
import 'package:flutter_getx_cart/state/cart_state.dart';
import 'package:flutter_getx_cart/utils/utils.dart';
import 'package:flutter_getx_cart/widgets/product_card.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';

void main() async {

  await GetStorage.init();
  runApp(const GetMaterialApp(home: MyHomePage()));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState()=>MyHomePageState();

}
class MyHomePageState extends State<MyHomePage>{
  final controller=Get.put(MyCartController());
  final box=GetStorage();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      String cartSave=await box.read(myCartKey);
      if(cartSave.length!=0 && cartSave.isNotEmpty){

        final listCart=jsonDecode(cartSave) as List<dynamic>;
        final listCartParsed=listCart.map((e) => CartModel.fromJson(e)).toList();
        if(listCartParsed.length>0) {
          controller.cart.value=listCartParsed;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: FutureBuilder(
        future: readJsonDatabase(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          else{
            var listProduct=snapshot.data as List<ProductModel>;
            return  Padding(padding:const EdgeInsets.all(8),
              child: ListView.builder(
              itemCount: listProduct.length,
              itemBuilder: (context,index){
               return ProductCard(productModel:listProduct[index]);
          }),
            );
          }
        },
      ),
      floatingActionButton: Obx(()=>Badge(
        position: const BadgePosition(top: 0,end: 1),
        animationDuration: const Duration(milliseconds: 200),
        animationType: BadgeAnimationType.scale,
        showBadge: true,
        badgeColor: Colors.red,
        badgeContent: Text(controller.cart.length>9 ? '9+':'${controller.cart.length}',style: const TextStyle(color: Colors.white),),
        child:  FloatingActionButton(
          onPressed: ()=>Get.to(()=>CartDetail()),
          child: const Icon(Icons.shopping_cart),
        ),
      )),
    ));
  }
}


