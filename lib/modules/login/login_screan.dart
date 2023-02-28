import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_layout.dart';
import 'package:shop/modules/register/register_screan.dart';
import 'package:shop/shared/components/companents.dart';
import 'package:shop/shared/components/constant.dart';
import 'package:shop/shared/cubit/LoginCubit/login_cubit.dart';
import 'package:shop/shared/cubit/shopstates.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/styles/colors.dart';

class LoginScrean extends StatelessWidget {
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return
     Scaffold(
        appBar: AppBar(),
        body: 
        BlocConsumer<LoginCubit, ShopStates>(
          listener: (context, state) {
          var cubit = LoginCubit.get(context);
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status) {
              CacheHelper.savedata(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token;
                print(token) ; 
                 toaster(
                  message: state.loginModel.message, state: ToastStates.success);
               
                 navigateAndFinish(context, ShopLayout());

                
                
              });
            } else {
              toaster(
                  message: state.loginModel.message, state: ToastStates.error);
            }
          }
        }, builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formkey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style:
                              Theme.of(context).textTheme.headline4?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultformfield(
                            controller: emailcontroller,
                            keyboardtype: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email adress can\'t be empty';
                              }
                            },
                            prefix: Icons.email_outlined,
                            label: 'Email'),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultformfield(
                            controller: passwordcontroller,
                            keyboardtype: TextInputType.visiblePassword,
                            suffixpressed: () {
                              cubit.chandevisibility();
                            },
                            password: cubit.ispassword,
                            onsubbmited: (value) {
                              if (formkey.currentState!.validate()) {
                                cubit.userLogin(
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text);
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'You should write your password';
                              }
                            },
                            suffix: cubit.suffix,
                            prefix: Icons.lock_outline,
                            label: 'Password'),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: ((context) => defaultButton(
                              background: defaultColor(),
                              function: () {
                                if (formkey.currentState!.validate()) {
                                  cubit.userLogin(
                                      email: emailcontroller.text,
                                      password: passwordcontroller.text);
                                }
                              },
                              text: 'login')),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(
                              color: defaultColor(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an accout?',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, Register());
                                },
                                child: Text(
                                  'REGISTER',
                                  style: TextStyle(color: defaultColor()),
                                ))
                          ],
                        ),
                      ]),
                ),
              ),
            ),
          );
        }));
  }
}
