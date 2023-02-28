import 'package:shop/modules/login/login_screan.dart';
import 'package:shop/shared/components/companents.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

String? token ;
late dynamic cost = 0  ; 
void signOut(context){
  CacheHelper.removedata(key:'token').then((value){
    if (value){
      token='' ;
      navigateAndFinish(context, LoginScrean()  ) ;
     
    }
  }) ;
}