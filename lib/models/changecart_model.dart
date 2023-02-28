class changeCartModel {
  late bool status ; 
  late String message ; 
  changeCartModel.fromjosn(Map<String , dynamic> jons){
     status = jons['status'] ; 
     message = jons['message'] ; 
  }

}