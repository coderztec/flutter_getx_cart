
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_cart/model/product_model.dart';

//ignore:must_be_immutable
class ProductImage extends StatelessWidget{

   ProductModel? productModel;
  ProductImage({this.productModel});

  @override
  Widget build(BuildContext context) {
   return CachedNetworkImage(imageUrl: productModel!.imageUrl,
            fit: BoxFit.cover,
            errorWidget: (context,url,error)=>const Icon(Icons.image),
            progressIndicatorBuilder: (context,url,downloadProgess)=>const Padding(
                padding:EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator(),),
            ),

   );
  }
}