import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_layout.dart';
import 'package:shop/modules/login/login_screan.dart';
import 'package:shop/modules/onboarding/onboarding_screan.dart';
import 'package:shop/modules/payment/payment_screan.dart';
import 'package:shop/shared/components/constant.dart';
import 'package:shop/shared/cubit/LoginCubit/login_cubit.dart';
import 'package:shop/shared/cubit/RegisterCubit/register_cubit.dart';
import 'package:shop/shared/cubit/bloc_observer.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/network/remote/Dio_Helper/dio_helper.dart';
import 'package:shop/shared/network/remote/Dio_Helper/dio_payment.dart';
import 'package:shop/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  DioPayment.init();
  await CacheHelper.init();
  bool? notfirstuse = CacheHelper.getdata(key: 'onboarding');
  token = CacheHelper.getdata(key: 'token');
  late Widget startwidget;
  if (notfirstuse != null) {
    if (token != null) {
      startwidget = const ShopLayout();
    } else {
      startwidget = LoginScrean();
    }
  } else {
    startwidget = OnboardingScrean();
  }

  runApp(MyApp(startwidget));
}

class MyApp extends StatelessWidget {
  Widget startwidget;
  MyApp(this.startwidget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
      ],
      child: MaterialApp(
        theme: themelight(),
        darkTheme: themeDark(),
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: startwidget,
      ),
    );
  }
}
