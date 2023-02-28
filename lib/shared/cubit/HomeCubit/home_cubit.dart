
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/changefavourites_models.dart';
import 'package:shop/models/home_models.dart';
import 'package:shop/models/incart_model.dart';
import 'package:shop/models/infavourites_model.dart';
import 'package:shop/models/profile_model.dart';
import 'package:shop/modules/Card/card_screan.dart';
import 'package:shop/modules/categories/categories_screan.dart';
import 'package:shop/modules/favourites/favourites_screan.dart';
import 'package:shop/modules/products/products_screan.dart';
import 'package:shop/modules/settings/settings_screan.dart';
import 'package:shop/shared/components/constant.dart';
import 'package:shop/shared/cubit/shopstates.dart';
import 'package:shop/shared/network/remote/Dio_Helper/dio_helper.dart';
import 'package:shop/shared/network/remote/end_points.dart';
import '../../../models/categories_models.dart';
import '../../../models/changecart_model.dart';

class HomeCubit extends Cubit<ShopStates> {
  HomeCubit() : super(ShopInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;
  List<Widget> ShopScreans = [
    ProductsScrean(),
    CategoriesScrean(),
    FavouritesScrean(),
    cardScrean(), 
    SettingScrean(),
  ];
  void changeButton(int index) {
    currentindex = index;
    emit(ChangeButtomNavItemState());
  }

  Map<int, bool> favourites = {};
  Map<int, bool> cart = {};

  HomeModel? homeModel;
  void gethomedata({
    required String? token,
  }) {
    emit(ShopHomeLoadingState());
    print(token);

    DioHelper.getdata(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromjosn(value.data);
      homeModel!.data.product.forEach(
        (element) {
          favourites.addAll({
            element.id: element.infavourites,
          });
          cart.addAll({
              element.id: element.incart,
          }
          );
        },
      );
      print(favourites.toString());

      emit(ShopHomeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopHomeErrorState());
    });
  }


  ChangeFavouritesModels ?  favouritesModels ; 

  void changefavourites(int id) {
    favourites[id] = !favourites[id]! ;
    emit(ShopChangeFavouritesLoadingState()) ;
    DioHelper.postdata(
      url: FAVOURITES, 
      token: token, 
      data: {'product_id': id} )
        .then((value) {
          favouritesModels =ChangeFavouritesModels.fromjosn(value.data) ;
          print(value.data);
          if (!favouritesModels!.status){
            favourites[id] = !favourites[id]! ;
          }else {
            getfavourites() ;
          }

     
      emit(ShopChangeFavouritesSuccessState(favouritesModels!));
    }).catchError((error) {
      favourites[id] = !favourites[id]! ;
      emit(ShopChangeFavouritesErrorState());
    });
  }

  CategoriesModel? categoriesmodel;
  void getcategoriesdata() {
    emit(ShopHomeLoadingState());
    DioHelper.getdata(url: CATAGORIES).then((value) {
      categoriesmodel = CategoriesModel.fromjosn(value.data);
      emit(ShopCategoriesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopCategoriesErrorState());
    });
  }

  InFavouritesModel ? inFavouritesModel ; 
  void getfavourites(){
    emit(ShopGetFavouritesloadingState()) ;
    DioHelper.getdata(url: FAVOURITES , token: token ).then((value) {
      inFavouritesModel = InFavouritesModel.fromjosn(value.data) ; 
      
      emit(ShopGetFavouritesSuccessState()) ;

    }) .catchError((error){
      print(error.toString()) ;
      emit(ShopGetFavouritesErrorState()) ; 
    });


  }
  ProfileModel ? userModel ;  
  void getprofiledata(){
    emit(ShopGetProfileloadingState()) ;
    DioHelper.getdata(url: PROFILE ,
     token: token ).then((value) {
      userModel = ProfileModel.fromjosn(value.data) ; 
     
      emit(ShopGetPrfileSuccessState()) ;

    }) .catchError((error){
      print(error.toString()) ;
      emit(ShopGetProfileErrorState()) ; 
    });

  

  }
   
  void updateprofiledata({
    required String name , 
    required String  phone , 
    required String email , 
  }){
    emit(ShopUpdateProfileloadingState()) ;
    DioHelper.putdata(url: UPDATE_DATE ,
     token: token , data: {
      'name' : name , 
      'phone': phone , 
      'email':email,
     }).then((value) {
      userModel = ProfileModel.fromjosn(value.data) ; 
     
      emit(ShopUpdatePrfileSuccessState()) ;

    }) .catchError((error){
      print(error.toString()) ;
      emit(ShopUpdateProfileErrorState()) ; 
    });
    }

    changeCartModel ?  cartModel; 
    

  void changecart (int id) {
    cart[id] = !cart[id]! ;
    emit(ShopChangeCartLoadingState()) ;
    DioHelper.postdata(
      url: CART, 
      token: token, 
      data: {'product_id': id} )
        .then((value) {
          cartModel = changeCartModel.fromjosn(value.data) ;
          print(value.data);
          if (!cartModel!.status){
            cart[id] = !cart[id]! ;
          }else {
            getcart() ;
          }

     
      emit(ShopChangeCartSuccessState(cartModel!));
    }).catchError((error) {
      cart[id] = !cart[id]! ;
      emit(ShopChangeCartErrorState());
    });
  }


  IncartModel ? incartModel ; 
  void getcart(){
    emit(ShopGetcartloadingState()) ;
    DioHelper.getdata(url: CART , token: token ).then((value) {
      incartModel = IncartModel.fromjosn(value.data) ; 
      
      emit(ShopGetcartSuccessState()) ;

    }) .catchError((error){
      print(error.toString()) ;
      emit(ShopGetcartErrorState()) ; 
    });

  }

}
