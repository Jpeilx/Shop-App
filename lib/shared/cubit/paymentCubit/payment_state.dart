part of 'payment_cubit.dart';


abstract class PaymentStates {}

class PaymentInitial extends PaymentStates {}
class GetTokenLoadingState extends PaymentStates {}
class GetTokenSucessState extends PaymentStates {}
class GetTokenErrorState extends PaymentStates {
   
  
}
class PaymentLoadingState extends PaymentStates {}
class PaymentSucessState extends PaymentStates {}
class PaymentErrorState extends PaymentStates {
}
