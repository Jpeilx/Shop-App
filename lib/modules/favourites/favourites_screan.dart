import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/infavourites_model.dart';
import 'package:shop/shared/cubit/HomeCubit/home_cubit.dart';
import 'package:shop/shared/cubit/shopstates.dart';

import '../../shared/styles/colors.dart';


class FavouritesScrean extends StatelessWidget {
  const FavouritesScrean ({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,ShopStates>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context) ;
        return ConditionalBuilder (
          condition: state is!  ShopGetFavouritesloadingState,
          builder: (context)=> ListView.separated(
            physics: const BouncingScrollPhysics() ,
            itemBuilder:(context , index)=>buildfavourites(cubit.inFavouritesModel!.data.data[index] , cubit , context) ,
             separatorBuilder: (context, index) => const SizedBox(
                  height: 0,
                ),
              itemCount: cubit.inFavouritesModel!.data.data.length),
          fallback: (context) => Center(child: CircularProgressIndicator(color: defaultColor()), ),
        ) ;
      }
      ) ;
       
    
  }
Widget buildfavourites(Product model , HomeCubit cubit , context ) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20) ,
          color: Colors.white,
          border: Border.all(
            color: defaultColor(),
            width: 1 ,
          )
        ),
        
        child: Column(
          children: [
            Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      image: CachedNetworkImageProvider(model.image),
                      width: double.infinity,
                      height: 200,
                    ),
                    if (model.discount != 0)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.red,
                        child: const Text(
                          'DISCOUNT',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 8),
                        ),
                      )
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:
                        const TextStyle(height: 1.4, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: defaultColor(),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldprice.round()}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            cubit.changefavourites(model.id) ; 
                            
                          },
                          icon: CircleAvatar (
                            backgroundColor: HomeCubit.get(context).favourites[model.id]!  ? defaultColor(): Colors.grey  ,
                            radius : 15 ,
                            child: const Icon(
                              Icons.favorite_border,
                              size: 20,
                            ),
                          )),
                          IconButton(
                        onPressed: () {
                          cubit.changecart(model.id) ; 
                          
                        },
                        icon: CircleAvatar (
                          backgroundColor: HomeCubit.get(context).cart[model.id]!  ? defaultColor(): Colors.grey  ,
                          radius : 15 ,
                          child: const Icon(
                            Icons.shopping_cart_outlined,
                            size: 20,
                          ),
                        ))
                    ],
                  ) ,
                  
                
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
