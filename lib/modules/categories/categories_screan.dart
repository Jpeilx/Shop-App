import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/categories_models.dart';
import 'package:shop/shared/cubit/HomeCubit/home_cubit.dart';
import 'package:shop/shared/cubit/shopstates.dart';

class CategoriesScrean extends StatelessWidget {
  const CategoriesScrean({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) { 
      var cubit = HomeCubit.get(context) ; 
        return ListView.separated(
          physics: const   BouncingScrollPhysics() ,
          itemBuilder: (context, index) => buildcatItem(cubit.categoriesmodel!.data.data[index]),
          separatorBuilder: ((context, index) => const SizedBox(
                height: 20,
              )),
          itemCount: cubit.categoriesmodel!.data.data.length ) ; }
    );
  }

  Widget buildcatItem(DataModel data ) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: CachedNetworkImageProvider(
                data.image),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 24,
          ),
          Text(
            data.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios))
        ],
      ),
    );
  }
}
