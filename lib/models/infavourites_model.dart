class InFavouritesModel {
  late bool status ; 
  String ? message ; 
  late  Data data; 
  InFavouritesModel.fromjosn(Map <String , dynamic> jons){
    status =  jons['status'] ; 
    message = jons['message'] ; 
    data = Data.fromjosn(jons['data']) ;

  }

}
class Data {
  late int currentpage ; 
  List <Product> data =[] ;
  Data.fromjosn(Map <String , dynamic > jons){
     currentpage = jons ['current_page'] ;
     jons['data'].forEach((element){
      data.add(Product.fromjosn(element['product'])) ;
     }) ;


  }

}


class Product{
  late int id ; 
  late dynamic price ; 
  late dynamic oldprice ; 
  late dynamic discount ; 
  late String image ; 
  late String name ; 
  late String description ; 

  Product.fromjosn(Map <String , dynamic > jons){
    id = jons['id'] ; 
    price = jons ['price'] ; 
    oldprice = jons['old_price'] ;
    discount = jons['discount'] ; 
    image = jons['image'] ;
    name =jons['name'] ;
    description = jons['description'] ;
  }
}