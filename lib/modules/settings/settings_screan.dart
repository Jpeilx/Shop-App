import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/components/companents.dart';
import 'package:shop/shared/components/constant.dart';
import 'package:shop/shared/cubit/HomeCubit/home_cubit.dart';
import 'package:shop/shared/cubit/shopstates.dart';
import 'package:shop/shared/styles/colors.dart';

import '../../models/profile_model.dart';


class SettingScrean extends StatelessWidget {
  SettingScrean({super.key});
  var formkey = GlobalKey<FormState>() ;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          if (cubit.userModel?.data!=null){
          nameController.text =cubit.userModel!.data!.name ;
          emailController.text =cubit.userModel!.data!.email ;
          phoneController.text =cubit.userModel!.data!.phone ;
          }

          return buildSetting(cubit.userModel?.data , context , cubit);
        });
  }

  Widget buildSetting(ProfileData ?  data ,context , HomeCubit cubit) {
    
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: SingleChildScrollView (
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (State is ShopUpdateProfileloadingState)
                  LinearProgressIndicator(color: defaultColor()) 
              ,
              const SizedBox(
                height: 20,
              ),
               CircleAvatar(
                radius: 80,
                child:  Image.asset('assets/images/user.jpg' , fit: BoxFit.fill,),
              ),
              const SizedBox(height:20 ,),
              defaultformfield(
                  controller: nameController,
                  keyboardtype: TextInputType.name,
                  validator: (value) {
                    
                    if (value!.isEmpty) {
                      return 'name field can not be empty';
                    }
                  },
                  prefix: Icons.person,
                  label: 'name'),
              const SizedBox(
                height: 20,
              ),
              defaultformfield(
                  controller: emailController,
                  keyboardtype: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email field can not be empty';
                    }
                  },
                  prefix: Icons.mail,
                  label: 'Email'),
              const SizedBox(
                height: 20,
              ),
              defaultformfield(
                  controller: phoneController,
                  keyboardtype: TextInputType.phone ,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'phone number field can not be empty';
                    }
                  },
                  prefix: Icons.phone ,
                  label: 'Phone Number') , 
                  const SizedBox(
                height: 20,
              ),
              defaultButton(background: defaultColor() , function:(){
                if (formkey.currentState!.validate()) {
                  cubit.updateprofiledata(name: nameController.text
                , phone: phoneController.text
                , email: emailController.text) ;
                }
              }, text: 'UPDATE' ) , 
              const SizedBox(height: 25,) , 
              
              InkWell (
                onTap: (){
                  signOut(context) ; 
                },
                
                child: Container(
                  width: 115,
                  child: Row(
                    children: [
                      Text('Logout' , style: TextStyle(
                        color: defaultColor() , 
                        fontSize:  20, 
                        fontWeight: FontWeight.bold
                      ),  ) , 
                      const SizedBox(
                        width: 10,
                      ),
                       Icon(Icons.logout , color: defaultColor(), size: 35, ),
                    ],
                  ),
                ),
              ) ,
            ],
          ),
        ),
      ),
    );
  }
}
