import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/components/companents.dart';
import 'package:shop/shared/cubit/shopstates.dart';
import 'package:shop/shared/styles/colors.dart';
import '../../models/search_model.dart';
import '../../shared/cubit/search_Cubit/search_cubit.dart';

class SearchScrean extends StatelessWidget {
  SearchScrean({super.key});
  var searchController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) => searchCubit()),
      child: BlocConsumer<searchCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var searchcubit = searchCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [
                  defaultformfield(
                      controller: searchController,
                      keyboardtype: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Search field can not be empty';
                        }
                      },
                      onsubbmited: (String value) {
                        searchcubit.search(text: value);
                      },
                      prefix: Icons.search,
                      label: 'Search'),
                  const SizedBox(
                    height: 15,
                  ),
                  if (state is ShopSearchloadingState)
                    LinearProgressIndicator(
                      color: defaultColor(),
                    ),
                  if (state is ShopSearchSuccessState &&
                      searchcubit.searchData.data != null)
                    Expanded(
                      child: ListView.separated(
                         physics: const BouncingScrollPhysics() ,
                          itemBuilder: ((context, index) => searchItem(
                              searchcubit.searchData.data!.data[index],
                              context)),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 30),
                          itemCount: searchcubit.searchData.data!.data.length),
                    )
                ]),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget searchItem(SearchProduct data, context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: NetworkImage(data.image),
              width: 120,
              height: 120,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        height: 1.4, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${data.price.round()}',
                        style: TextStyle(color: defaultColor()),
                      ),
                      const Spacer(),
                      CircleAvatar(
                        backgroundColor:
                            data.infavorites ? defaultColor() : Colors.grey,
                        radius: 15,
                        child: const Icon(
                          Icons.favorite_border,
                          size: 20,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
