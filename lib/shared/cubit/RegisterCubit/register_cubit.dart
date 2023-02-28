import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop/models/register_model.dart';
import 'package:shop/shared/cubit/shopstates.dart';
import 'package:shop/shared/network/remote/end_points.dart';

import '../../network/remote/Dio_Helper/dio_helper.dart';

class RegisterCubit extends Cubit<ShopStates> {
  RegisterCubit() : super(ShopInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  late RegisterModel userdata;

  void userRegister(
      {
      required String name,
      required String phone,
      required String email,
      required String password
      }) {
    emit(ShopRegisterLoadingState());
    print(name);
    print(email);
    print(phone);
    print(password);
    DioHelper.postdata(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      userdata = RegisterModel.fromjosn(value.data);
      emit(ShopRegisterSuccessState(userdata));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  bool ispassword = true;
  IconData suffix = Icons.visibility_off;

  void chandevisibility() {
    if (ispassword) {
      ispassword = !ispassword;
      suffix = Icons.visibility;
    } else {
      ispassword = !ispassword;
      suffix = Icons.visibility_off;
    }
    emit(ChangePasswordState());
  }
}
