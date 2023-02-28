import 'package:shop/models/changefavourites_models.dart';
import 'package:shop/models/login_models.dart';
import 'package:shop/models/register_model.dart';

import '../../models/changecart_model.dart';

abstract class ShopStates {} 
 class ShopInitialState extends ShopStates {} 
 class ShopLoginLoadingState extends ShopStates {} 
 class ShopLoginSuccessState extends ShopStates {
  final LoginModel loginModel ; 
  ShopLoginSuccessState(this.loginModel) ; 

 } 
 class ShopLoginErrorState extends ShopStates {
  final String error ; 
  ShopLoginErrorState(this.error) ; 
} 

class ChangePasswordVisibilityState extends ShopStates {} 
class ChangeButtomNavItemState extends ShopStates {} 
class ShopHomeLoadingState extends ShopStates {} 
class ShopHomeSuccessState extends ShopStates {} 
class ShopHomeErrorState extends ShopStates {} 
class ShopCategoriesSuccessState extends ShopStates {} 
class ShopCategoriesErrorState extends ShopStates {} 
class ShopChangeFavouritesSuccessState extends ShopStates {
  final ChangeFavouritesModels model ; 
   ShopChangeFavouritesSuccessState(this.model) ;
} 
class ShopChangeFavouritesLoadingState extends ShopStates {} 
class ShopChangeFavouritesErrorState extends ShopStates {} 
class ShopGetFavouritesSuccessState extends ShopStates {} 
class ShopGetFavouritesErrorState extends ShopStates {} 
class ShopGetFavouritesloadingState extends ShopStates {} 
class ShopGetPrfileSuccessState extends ShopStates {} 
class ShopGetProfileErrorState extends ShopStates {} 
class ShopGetProfileloadingState extends ShopStates {} 
class ShopRegisterLoadingState extends ShopStates {} 
 class ShopRegisterSuccessState extends ShopStates {
  final RegisterModel Registerdata ; 
  ShopRegisterSuccessState(this.Registerdata) ;

 } 
 class ShopRegisterErrorState extends ShopStates {
  final String error ; 
  ShopRegisterErrorState(this.error) ; 
} 

class ChangePasswordState extends ShopStates {}
class ShopUpdatePrfileSuccessState extends ShopStates {} 
class ShopUpdateProfileErrorState extends ShopStates {} 
class ShopUpdateProfileloadingState extends ShopStates {} 
class ShopSearchSuccessState extends ShopStates {} 
class ShopSearchErrorState extends ShopStates {} 
class ShopSearchloadingState extends ShopStates {} 
class ShopChangeCartSuccessState extends ShopStates {
  final changeCartModel model ; 
   ShopChangeCartSuccessState(this.model) ;
} 
class ShopChangeCartLoadingState extends ShopStates {} 
class ShopChangeCartErrorState extends ShopStates {}
class ShopGetcartSuccessState extends ShopStates {} 
class ShopGetcartErrorState extends ShopStates {} 
class ShopGetcartloadingState extends ShopStates {}

