
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/login_models.dart';
import 'package:shop/shared/cubit/HomeCubit/home_cubit.dart';
import 'package:shop/shared/cubit/shopstates.dart';
import 'package:shop/shared/network/remote/Dio_Helper/dio_helper.dart';

import '../../network/remote/end_points.dart';

class LoginCubit extends Cubit<ShopStates> {
  LoginCubit() : super(ShopInitialState());
  
     
  static LoginCubit get(context) => BlocProvider.of(context);
  late LoginModel loginmodel ; 

  void userLogin({required String email, required String password}) {
    emit(ShopLoginLoadingState()) ;
    DioHelper.postdata(url: LOGIN,
     data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginmodel = LoginModel.fromjosn(value.data) ; 
      emit(ShopLoginSuccessState(loginmodel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  bool ispassword = true ; 
  IconData suffix =  Icons.visibility_off;

  void chandevisibility (){
    if (ispassword){
      ispassword=!ispassword ; 
      suffix = Icons.visibility ;
    }
    else{
      ispassword=!ispassword ; 
      suffix = Icons.visibility_off ;

    }
    emit(ChangePasswordVisibilityState()) ;
  }
  
}


