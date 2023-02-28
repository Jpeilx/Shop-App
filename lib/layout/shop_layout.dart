import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/search/search_screan.dart';
import 'package:shop/shared/components/companents.dart';
import 'package:shop/shared/styles/colors.dart';
import '../shared/components/constant.dart';
import '../shared/cubit/HomeCubit/home_cubit.dart';
import '../shared/cubit/shopstates.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
            ..gethomedata(token: token)
            ..getcategoriesdata()
            ..getfavourites()
            ..getprofiledata()
            ..getcart(),
      child: BlocConsumer<HomeCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('SAllA'),
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(context, SearchScrean());
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
            body: cubit.ShopScreans[cubit.currentindex],
            bottomNavigationBar: CurvedNavigationBar(
                color: defaultColor(),
                backgroundColor: Colors.white,
                onTap: (index) {
                  cubit.changeButton(index);
                },
                index: cubit.currentindex,
                animationDuration: const Duration(milliseconds: 400),
                items: const [
                  CurvedNavigationBarItem(
                      child: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      label: 'Home',
                      labelStyle: TextStyle(color: Colors.white)),
                  CurvedNavigationBarItem(
                      child: Icon(
                        Icons.apps,
                        color: Colors.white,
                      ),
                      label: 'Categories',
                      labelStyle: TextStyle(color: Colors.white)),
                  CurvedNavigationBarItem(
                      child: Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
                      label: 'Favorites',
                      labelStyle: TextStyle(color: Colors.white)),
                  CurvedNavigationBarItem(
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      label: 'Carts',
                      labelStyle: TextStyle(color: Colors.white)),
                  CurvedNavigationBarItem(
                      child: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      label: 'settings',
                      labelStyle: TextStyle(color: Colors.white))
                ]),
          );
        },
      ),
    );
  }
}
