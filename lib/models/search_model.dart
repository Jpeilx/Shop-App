class SearchModel {
  late bool status ; 
  String ? message ; 
  Data ?  data; 
  SearchModel.fromjosn(Map <String , dynamic> jons){
    status =  jons['status'] ; 
    message = jons['message'] ; 
    if (jons['data'] !=null) {
      data = Data.fromjosn(jons['data']) ;
    }

  }

}
class Data {
  late int currentpage ; 
  List <SearchProduct> data =[] ;
  Data.fromjosn(Map <String , dynamic > jons){
     currentpage = jons ['current_page'] ;
     jons['data'].forEach((element){
      data.add(SearchProduct.fromjosn(element)) ;
     }) ;


  }

}


class SearchProduct{
  late int id ; 
  late dynamic price ;   
  late String image ; 
  late String name ; 
  late String description ; 
  late bool infavorites ; 
  late bool incart ; 

  SearchProduct.fromjosn(Map <String , dynamic > jons){
    id = jons['id'] ; 
    price = jons ['price'] ; 
    image = jons['image'] ;
    name =jons['name'] ;
    description = jons['description'] ;
    infavorites=jons['in_favorites'] ;
    incart = jons['in_cart'] ;
  }
}