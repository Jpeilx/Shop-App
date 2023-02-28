
import '../shared/components/constant.dart';

class IncartModel {
 late bool status ; 
 String ? message ; 
 Data ? data ; 
 IncartModel.fromjosn(Map<String , dynamic>jons){
  status = jons['status'] ; 
  message = jons['message'] ;
  if (jons['data']!=null) {
    data = Data.fromjosn(jons['data']) ;
  }
 }


}
class Data {
  List <CartItem> CartItems =[] ; 
  Data.fromjosn(Map<String , dynamic>jons){
    jons['cart_items'].forEach((element) {
      CartItems.add(CartItem.fromjosn(element)) ;
      
    }) ;
  }

}
class CartItem{
 late int id ; 
 late int quantity ; 
 late CartProduct product ; 
 CartItem.fromjosn(Map<String , dynamic> jons){
  id = jons['id'] ; 
  quantity = jons['quantity'] ; 
  product  =  CartProduct.fromjosn(jons ['product']) ; 
 }
}
class CartProduct {
  late int id ; 
  late dynamic price ; 
  late dynamic oldprice ;
  late dynamic discont ;
  late String image ; 
  late String name ; 
  late String description ; 
  late bool infavourites ; 
  late bool incart ; 
  CartProduct.fromjosn(Map<String , dynamic > jons){
    id = jons['id'] ; 
    price = jons['price'] ; 
    oldprice = jons['old_price'] ; 
    discont = jons['discount'] ; 
    image =  jons['image'] ; 
    name  = jons['name'] ; 
    description  = jons['description'] ; 
    infavourites  = jons['in_favorites'] ; 
    incart  = jons['in_cart'] ; 
    cost+=price ; 
  }


}