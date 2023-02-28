class CategoriesModel {
  late bool states ;
  late CategoriesDataModel data ; 
  CategoriesModel.fromjosn(Map<String , dynamic > josn){
    states=josn['status'] ; 
    data = CategoriesDataModel.fromjosn(josn['data']) ;
  }


}
class CategoriesDataModel{
 late int currentpage ; 
 List<DataModel> data =[] ; 
 CategoriesDataModel.fromjosn(Map<String , dynamic>josn){
  currentpage = josn['current_page'] ; 
  josn['data'].forEach((element){
    data.add(DataModel.fromjosn(element)) ; 
  });
 }

}
class DataModel{
  late int id ; 
  late String name  ; 
  late  String image ; 
  DataModel.fromjosn(Map<String , dynamic> josn){
    id = josn['id'] ;
    name = josn['name'] ;
    image = josn['image'] ;

  }
}