import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/categories_models.dart';
import 'package:shop/models/home_models.dart';
import 'package:shop/shared/components/companents.dart';
import 'package:shop/shared/cubit/HomeCubit/home_cubit.dart';
import 'package:shop/shared/cubit/shopstates.dart';
import 'package:shop/shared/styles/colors.dart';

class ProductsScrean extends StatelessWidget {
  const ProductsScrean({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, ShopStates>(
        listener: (context, state) {
          if (state is ShopChangeFavouritesSuccessState){
            if (!state.model.status){
              toaster(message: state.model.message, state: ToastStates.error ) ;
            }
          }
        },
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          
          return ConditionalBuilder(
            condition: cubit.homeModel != null && cubit.categoriesmodel != null,
            builder: (context) => productBuilder(cubit.homeModel , cubit.categoriesmodel , context , cubit),
            fallback: (context) => Center(
              child: CircularProgressIndicator(
                color: defaultColor(),
              ),
            ),
          );
        });
  }

  Widget productBuilder(HomeModel? model , CategoriesModel? categoriesmodel , context ,HomeCubit cubit ) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
              items: model!.data.banners.map((e) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(e.image), fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                initialPage: 0,
                height: 175,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1.0,
              )),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 20,) ,
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics() ,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildCategoriesItem(categoriesmodel.data.data[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 15,
                          ),
                      itemCount:categoriesmodel!.data.data.length ),
                ),
                const SizedBox(height: 25,) ,
                const Text(
                  'New Products',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1.1 / 1.8,
              children: List.generate(model.data.product.length,
                  (index) => buildproductgrid(model.data.product[index],context , cubit)),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoriesItem(DataModel data) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
         Image(
          image: CachedNetworkImageProvider(
              data.image),
          fit: BoxFit.cover,
          height: 100,
          width: 100,
        ),
        Container(
          color: defaultColor().withOpacity(.8),
          width: 100,
          child:  Text(
            data.name ,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }

  Widget buildproductgrid(ProductModel model , context , HomeCubit cubit) {
    return Container(
      color: Colors.white,
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
                          fontSize: 11,
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
    );
  }
}
