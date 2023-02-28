import 'package:flutter/gestures.dart';

class HomeModel {
  late bool status ; 
  late HomeDataModel data ; 
  HomeModel.fromjosn(Map<String , dynamic> json){
     status = json['status'] ; 
     data= HomeDataModel.fromjosn(json['data']) ;
  }
 
}
class HomeDataModel {
  List<BannersModel> banners = [] ; 
  List<ProductModel> product = [] ; 
  HomeDataModel.fromjosn(Map<String , dynamic> json){
    json['banners'].forEach((elment){
        banners.add(BannersModel.fromjosn(elment)) ;

    }) ;
    json['products'].forEach((elment){
        product.add(ProductModel.fromjosn(elment)) ;
    }) ;
  }
}
class BannersModel{
  late int id ; 
  late String image ; 
  BannersModel.fromjosn(Map<String , dynamic> json){
     id = json['id']  ;
     image  = json['image']  ;
  }

}
class ProductModel{
  late int id ; 
  late dynamic price ; 
  late dynamic oldprice ; 
  late dynamic discount ; 
  late String image  ; 
  late String name ; 
  late bool infavourites ; 
  late bool incart ; 
   ProductModel.fromjosn(Map<String , dynamic> json){
    id =  json['id'] ; 
    price = json['price'] ;
    oldprice = json['old_price'] ;
    discount = json['discount'] ;
    image = json['image'] ;
    name = json['name'] ;
    infavourites = json['in_favorites'] ;
    incart = json['in_cart'] ;
   }


}