import 'package:flutter/material.dart';
import 'package:shop/modules/login/login_screan.dart';
import 'package:shop/shared/components/companents.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({required this.image, required this.title, required this.body});
}

class OnboardingScrean extends StatefulWidget {
  OnboardingScrean({super.key});

  @override
  State<OnboardingScrean> createState() => _OnboardingScreanState();
}

class _OnboardingScreanState extends State<OnboardingScrean> {
  List<BoardingModel> itemModel = [
    BoardingModel(
        image: 'assets/images/onboarding_1.png',
        title: 'Search in defferent Catagories',
        body: 'Find Products you want by searching in different catagories '),
    BoardingModel(
        image: 'assets/images/onboarding3.png',
        title: 'Confirm Your order and wait',
        body: 'After putting your products in card confirm order and wait until arriving '),
    BoardingModel(
        image: 'assets/images/onboarding2.png',
        title: 'Easy Payment',
        body: 'Enter Your Card Data and pay with one click'),
  ];

  var boaredcontroller = PageController();
  bool islast = false ; 

  void skip (){
    CacheHelper.savedata(key: 'onboarding', value: true ).then((value) {
      if (true) {
        navigateAndFinish(context, LoginScrean() ) ;
      } 
    }) ;
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: skip 
            
            , child: const  Text('SKIP' , style: TextStyle(fontWeight: FontWeight.bold),))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                  child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildboardingItem(itemModel[index]),
                itemCount: itemModel.length,
                controller: boaredcontroller,
                onPageChanged: (index){
                  if (index == itemModel.length -1){
                    setState(() {
                      islast = true ; 
                    });
                  }
                  else{
                    setState(() {
                      islast = false ; 
                    });
                  }
                },
              )),
              const SizedBox(
                height: 45,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boaredcontroller,
                    count: itemModel.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: defaultColor(),
                      dotColor: Colors.grey , 
                      dotHeight: 10 , 
                      expansionFactor: 5 , 
                      dotWidth: 10 , 
                      spacing: 5 , 

                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (islast ){
                       skip()  ; 
                      
                      }
                      else{
                        boaredcontroller.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: const Icon(Icons.arrow_forward),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget buildboardingItem(BoardingModel model) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(child: Image.asset(model.image)),
      Text(
        model.title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
      ),
      const SizedBox(
        height: 15,
      ),
      Text(
        model.body,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
      )
    ]);
  }
}
