
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultformfield({
  required TextEditingController? controller,
  required TextInputType? keyboardtype,
  void Function(String)? onsubbmited,
  void Function()? suffixpressed,
  Function(String)? onchanged,
  required String? Function(String?)? validator,
  IconData? prefix,
  required String? label,
  void Function()? ontap,
  bool password = false,
  IconData? suffix,
}) {
  return TextFormField(
    controller: controller,
    obscureText: password,
    keyboardType: keyboardtype,
    onFieldSubmitted: onsubbmited,
    onChanged: onchanged,
    onTap: ontap,
    validator: validator,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(prefix),
      suffixIcon: suffix != null
          ? IconButton(onPressed: suffixpressed, icon: Icon(suffix))
          : null,
      border: const OutlineInputBorder(),
    ),
  );
}

void navigateTo(context, object) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => object));
}

void navigateAndFinish(context, object) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => object), (route) => false);
}

Widget defaultButton({
  double width = double.infinity,
  required Color background,
  bool isUpperCase = true,
  double radius = 3.0,
  required function,
  required String text, 
  
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
           
        
            fontSize: 22 ,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );

void toaster({
  required String message,
  required ToastStates state ,
}) {
  Fluttertoast.showToast(
      webShowClose: true,
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chosetoastcolor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates {
  success , 
  error , 
  warrning 
}
Color chosetoastcolor (ToastStates state ){
   if (state == ToastStates.success) {
     return Colors.green ;
   } 
   else if  (state == ToastStates.error) {
     return Colors.red ;
   } 
   else {
     return Colors.amber ;
   }  
}