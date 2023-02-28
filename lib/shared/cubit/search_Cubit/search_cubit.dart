import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/search_model.dart';
import 'package:shop/shared/components/constant.dart';
import 'package:shop/shared/cubit/shopstates.dart';
import 'package:shop/shared/network/remote/end_points.dart';

import '../../network/remote/Dio_Helper/dio_helper.dart';

class searchCubit extends Cubit <ShopStates>{
  searchCubit() :super(ShopInitialState()) ; 
  static searchCubit get(context) => BlocProvider.of(context) ; 

  late SearchModel searchData ; 

  void search(
      {
      required String text  , 
      }) {
    emit(ShopSearchloadingState());
    DioHelper.postdata(
    url:SEARCH ,
    token: token,
     data: {
      'text': text ,
    }).then((value) {
      searchData = SearchModel.fromjosn(value.data) ;
      print(searchData.data!.data[0].id);
      emit(ShopSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopSearchErrorState());
    });
}


}