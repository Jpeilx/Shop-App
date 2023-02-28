
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop/shared/network/remote/Dio_Helper/dio_payment.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentStates> {
  PaymentCubit() : super(PaymentInitial());
   static PaymentCubit get(context) => BlocProvider.of(context);
   
  void paymentNow({
    required String cardNumber,
    required int expiryMonth,
    required int expiryYear,
    required int amount,
  }) async {
    late String token;
    emit(GetTokenLoadingState());
    await DioPayment.getToken(
            number: cardNumber,
            expiryMonth: expiryMonth,
            expiryYear: expiryYear)
        .then((value) {
      token = value.data['token'];
      
      emit(GetTokenSucessState());
    }).catchError((error) {
      emit(GetTokenErrorState());
    });
  print(token);

  if (state is GetTokenSucessState) {
    emit(PaymentLoadingState());
    await DioPayment.payment(paymenttoken: token, amount: amount).then((value) {
      print(value.data);
      emit(PaymentSucessState());


    }).catchError((error){
      print(error);
      emit(PaymentErrorState());
    });
  }
  }
}
