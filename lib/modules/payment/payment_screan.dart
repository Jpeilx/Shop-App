import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_layout.dart';
import 'package:shop/modules/payment/card_design.dart';
import 'package:shop/shared/components/companents.dart';
import 'package:shop/shared/styles/colors.dart';
import '../../shared/cubit/paymentCubit/payment_cubit.dart';

class PaymentScreen extends StatelessWidget {
  final int amount;
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDataController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
   var formkey = GlobalKey<FormState>();
  PaymentScreen(this.amount);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Payment Gateway',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formkey ,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PaymentCard(),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Card Number' , style: TextStyle( fontSize: 20 , fontWeight: FontWeight.bold),),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultformfield(
                      controller: cardNumberController,
                      keyboardtype: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "You Should Enter Card Number";
                        }
                      },
                      prefix: Icons.credit_card,
                      label: 'Card'),
                  const SizedBox(height: 16.0),
                  const Text('Expiry Date' , style: TextStyle( fontSize: 20 , fontWeight: FontWeight.bold),),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultformfield(
                      controller: expiryDataController,
                      keyboardtype: TextInputType.streetAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "You Should Enter Experiy Data";
                        }
                      },
                      label: 'MM/YY'),
                  const SizedBox(height: 16.0),
                  const Text('Security Code' , style: TextStyle( fontSize: 20 , fontWeight: FontWeight.bold),),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultformfield(
                      controller: cvvController,
                      keyboardtype: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "You Should Enter CVV Number";
                        }
                      },
                      label: 'CVV'),
                  const SizedBox(height: 40.0),
                  BlocConsumer<PaymentCubit, PaymentStates>(
                    listener: (context, state) {
                      if (state is GetTokenLoadingState ||
                          state is PaymentLoadingState) {
                        const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is PaymentSucessState) {
                        toaster(
                            message: 'Successful Transaction',
                            state: ToastStates.success);
                        navigateTo(context, const ShopLayout());
                      }
                       if (state is GetTokenErrorState ||
                          state is PaymentErrorState) {
                        toaster(
                            message: 'Not valid Data', state: ToastStates.error);
                      }
                    },
                    builder: (context, state) {
                      
                     
                      return defaultButton(
                          background: defaultColor(),
                          function: () {
                          if (formkey.currentState!.validate()){
                            int expiryMonth =  int.parse(expiryDataController.text.substring(0,2));
                            int expiryYear =  int.parse(expiryDataController.text.substring(3,5));
                            print(expiryMonth);
                            print(expiryYear);
                            PaymentCubit.get(context).paymentNow(
                                cardNumber: cardNumberController.text ,
                                expiryMonth: expiryMonth,
                                expiryYear: expiryYear,
                                amount: amount );
                           } },
                          text: "pay now");
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
