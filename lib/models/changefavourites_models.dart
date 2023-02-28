class ChangeFavouritesModels{
  late bool status ; 
  late String message ; 
  ChangeFavouritesModels.fromjosn(Map<String , dynamic> jons ){
    status = jons ['status'] ;
    message = jons ['message'] ;

  }



}