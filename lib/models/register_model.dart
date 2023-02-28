class RegisterModel{
   
    late bool status ; 
    late String  message ; 
    RegisterData ? data ; 
    RegisterModel.fromjosn(Map<String , dynamic> json) {
        status = json['status'] ; 
        message = json['message'] ;
        if (json['data']!=null) {
          data  =  RegisterData.fromjosn(json['data']) ;
        }
    }
}
class RegisterData {
  late int  id ; 
  late String  name ; 
  late String  email ; 
  late  String   phone ; 
  late  String   image  ;  
  late  String  token ; 

   RegisterData.fromjosn(Map<String,dynamic>json){
    id = json['id'] ; 
    name  = json['name'] ; 
    email = json['email'] ; 
    phone = json['phone'] ; 
    image = json['image'] ; 
    token = json['token'] ; 
   }
}