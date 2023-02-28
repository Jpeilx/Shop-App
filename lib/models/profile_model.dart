class ProfileModel{
   
    late bool status ; 
    String ?   message ; 
    ProfileData ? data ; 
    ProfileModel.fromjosn(Map<String , dynamic> json) {
        status = json['status'] ; 
        message = json['message'] ;
        if (json['data']!=null) {
          data  =  ProfileData.fromjosn(json['data']) ;
        }
    }
}
class ProfileData {
  late int  id ; 
  late String  name ; 
  late String  email ; 
  late  String   phone ; 
  late  String   image  ; 
  late int points ; 
  late int credit ; 
  late  String  token ; 

   ProfileData.fromjosn(Map<String,dynamic>json){
    id = json['id'] ; 
    name  = json['name'] ; 
    email = json['email'] ; 
    phone = json['phone'] ; 
    image = json['image'] ; 
    points = json['points'] ; 
    credit = json['credit'] ; 
    token = json['token'] ; 
   }
}