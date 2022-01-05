
import 'package:flutter_getx_cart/model/product_model.dart';

class CartModel extends ProductModel{
  int quantity=0;

  CartModel({
    id,
    name,
    category,
    imageUrl,
    oldPrice,
    price,
      required this.quantity }):super(id: id,name: name,category: category,imageUrl: imageUrl,oldPrice: oldPrice,price: price);

  factory CartModel.fromJson(Map<String,dynamic>json){
    final product=ProductModel.fromJson(json);
    final quantity=json['quantity'];
    return CartModel(
        id:product.id,
      name:product.name,
      category: product.category,
      imageUrl:product.imageUrl,
      oldPrice:product.oldPrice,
      price:product.price,
      quantity:quantity
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['category'] = category;
    data['imageUrl'] = imageUrl;
    data['oldPrice'] = oldPrice;
    data['price'] = price;
    data['quantity']=quantity;
    return data;
  }
}