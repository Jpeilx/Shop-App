
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/shared/styles/colors.dart';

ThemeData themelight (){
  return ThemeData(
                scaffoldBackgroundColor: Colors.white,
                primarySwatch: defaultColor() ,
                appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                    iconTheme: IconThemeData(color: Colors.black),
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark,
                    )),
                bottomNavigationBarTheme:  BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: defaultColor(),
                  unselectedItemColor: Colors.grey,
                  backgroundColor: Colors.white,
                  elevation: 25,
                ),
                fontFamily: 'Janna' ,

              );
}
ThemeData themeDark(){
  return ThemeData(
                inputDecorationTheme: const InputDecorationTheme(
                  prefixIconColor: Colors.white , 
                  labelStyle: TextStyle(color: Colors.white),
                  floatingLabelStyle: TextStyle(color: Colors.deepOrange),
                  
                ),
                scaffoldBackgroundColor: HexColor('333739'),
                primarySwatch: Colors.deepOrange,
                appBarTheme: AppBarTheme(
                    backgroundColor: HexColor('333739'),
                    elevation: 0,
                    titleTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                    iconTheme: const IconThemeData(color: Colors.white),
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor('333739'),
                      statusBarIconBrightness: Brightness.light,
                    )),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey,
                  backgroundColor: HexColor('333739'),
                  elevation: 25,
                ),
                fontFamily: 'Janna'
              );
}