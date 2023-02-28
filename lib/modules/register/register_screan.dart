import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/cubit/RegisterCubit/register_cubit.dart';
import 'package:shop/shared/cubit/shopstates.dart';

import '../../layout/shop_layout.dart';
import '../../shared/components/companents.dart';
import '../../shared/components/constant.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';

class Register extends StatelessWidget {
  var namecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = RegisterCubit.get(context);
    return
     BlocConsumer<RegisterCubit,ShopStates>
     (
      listener: (context, state) {
      if (state is ShopRegisterSuccessState) {
        if (state.Registerdata.status) {
          CacheHelper.savedata(key: 'token', value: state.Registerdata.data!.token)
              .then((value) {
            token = state.Registerdata.data!.token;
            print(token);
            toaster(
                message: state.Registerdata.message, state: ToastStates.success);

            navigateAndFinish(context, ShopLayout());
          });
        } else {
          toaster(message: state.Registerdata.message, state: ToastStates.error);
        }
      }
    }, builder: (context, state) {
      return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formkey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Register',
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                      ),
                      Text(
                        'Register now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultformfield(
                          controller: namecontroller,
                          keyboardtype: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name field can\'t be empty';
                            }
                          },
                          prefix: Icons.person,
                          label: 'Name'),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultformfield(
                          controller: phonecontroller,
                          keyboardtype: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Phone field can\'t be empty';
                            }
                          },
                          prefix: Icons.phone,
                          label: 'Phone'),
                      const SizedBox(
                        height: 15,
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
                              cubit.userRegister(
                                  name: namecontroller.text,
                                  phone: phonecontroller.text,
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
                        condition: state is! ShopRegisterLoadingState,
                        builder: ((context) => defaultButton(
                            background: defaultColor(),
                            function: () {
                              if (formkey.currentState!.validate()) {
                                cubit.userRegister(
                                    name: namecontroller.text,
                                    phone: phonecontroller.text,
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text
                                    );
                              }
                            },
                            text: 'Register')),
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(
                            color: defaultColor(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ]),
              ),
            ),
          ),
        ),
      );
    });
  }
}
