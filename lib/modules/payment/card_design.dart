import 'package:flutter/material.dart';
import 'package:shop/shared/styles/colors.dart';

class PaymentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: 400,
      decoration: BoxDecoration(
      
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
           BoxShadow(
            color:defaultColor(),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         const  Padding(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Text(
              'Card Number',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
         const  Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              '**** **** **** 1234',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
         const  SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const  [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Card Holder',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Text(
                  'Expires',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const  [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Mohammed Jbeil',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Text(
                  '12/24',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
        
        ],
      ),
    );
  }
}
