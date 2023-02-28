import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/incart_model.dart';
import 'package:shop/modules/payment/payment_screan.dart';
import 'package:shop/shared/components/companents.dart';
import 'package:shop/shared/components/constant.dart';
import '../../shared/cubit/HomeCubit/home_cubit.dart';
import '../../shared/cubit/shopstates.dart';
import '../../shared/styles/colors.dart';

class cardScrean extends StatefulWidget {
  const cardScrean({super.key});

  @override
  State<cardScrean> createState() => _cardScreanState();
}

class _cardScreanState extends State<cardScrean> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return ConditionalBuilder(
            condition: state is! ShopGetcartloadingState,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView (
                physics: const BouncingScrollPhysics() ,
                child: Column(
                  children: [
                    Text('That will cost You $cost' , style: const  TextStyle(fontSize: 30  , fontWeight: FontWeight.bold),) , 
                    defaultButton(background: defaultColor() ,
                     function: (){
                      navigateTo(context, PaymentScreen((cost*100).toInt()));
                     },
                      text: 'PAY NOW '  ,) , 
                    const  SizedBox(height: 30,),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics() ,
                        
                        itemBuilder: (context, index) => buildCart(
                            cubit.incartModel!.data!.CartItems[index], cubit, context),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 30,
                            ),
                        itemCount: cubit.incartModel!.data!.CartItems.length),
                  ],
                ),
              ),
            ),
            fallback: (context) => Center(
              child: CircularProgressIndicator(color: defaultColor()),
            ),
          );
        });
  }

  Widget buildCart(CartItem item, HomeCubit cubit, context) { 
   
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          border: Border.all(
            color: defaultColor(),
            width: 1,
          )),
      child: Column(
        children: [
          Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: CachedNetworkImageProvider(item.product.image),
                    width: double.infinity,
                    height: 200,
                  ),
                  if (item.product.discont != 0)
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
                  item.product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      height: 1.4, fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    Text(
                      '${item.product.price.round()}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: defaultColor(),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (item.product.discont != 0)
                      Text(
                        '${item.product.oldprice.round()}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            item.quantity ++ ; 
                            cost +=item.product.price ;
                          });
                        },
                        icon: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.horizontal(
                              right: Radius.zero ,
                              left: Radius.circular(6)
                            ) ,
                            border: Border.all(
                              color: defaultColor(),
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            color: defaultColor(),
                            Icons.add,
                            size: 20,
                          ),
                        )),
                    const SizedBox(
                      width: 4,
                    ),
                    Text( item.quantity>=0 ?"${item.quantity}" :'0' , 
                    style: TextStyle( fontSize: 25 , fontWeight: FontWeight.bold  , color: defaultColor()),),
                    const SizedBox(
                      width: 4,
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            if (item.quantity>0) {
                              item.quantity-- ;
                              cost -=item.product.price ;
                            } 
                          });
                        },
                        icon: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.horizontal(
                              left: Radius.zero ,
                              right: Radius.circular(6)
                            ) ,
                            border: Border.all(
                              color: defaultColor(),
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            color: defaultColor(),
                            Icons.remove,
                            size: 20,
                          ),
                        )),
                    IconButton(
                        onPressed: () {
                          cubit.changecart(item.product.id);
                        },
                        icon: CircleAvatar(
                          backgroundColor:
                              HomeCubit.get(context).cart[item.product.id]!
                                  ? defaultColor()
                                  : Colors.grey,
                          radius: 15,
                          child: const Icon(
                            Icons.shopping_cart_outlined,
                            size: 20,
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
