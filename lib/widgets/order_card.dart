

import 'package:delivery_boy_app/utills/colors.dart';
import 'package:delivery_boy_app/widgets/custom_button.dart';
import 'package:delivery_boy_app/widgets/dash_vertical.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              )
            ),
            child: Row(
              children: [
                Text(
                    "New Order Available",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 15,),
                Text(
                    "₹320",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: buttonMainColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close),
                )
              ],
            ),

          ),
          Padding(padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                color: Colors.white,
                elevation: 1,
                shadowColor: Colors.black26,
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.brown[100],
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY1yjOaz-ncmlmm6Dqr1jg45dlJ4rbwut66Q&s'),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Text.rich(
                        TextSpan(
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500
                            ),
                          children: [
                            TextSpan(text: "Tender Coconut (Normal)"),
                            TextSpan(
                                text: " * 4",
                                style: TextStyle(
                                  color: Colors.black,
                                 )
                            )
                          ]
                        ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Icon(Icons.radio_button_checked, color: Colors.black,size: 20,),
                      SizedBox(height: 35, child: DashVerticalLine(dashHeight: 6, dashGap: 5,),),

                    ],
                  ),
                  SizedBox(width: 4,),
                  pickupAndDileveryInfo(
                      "Pickup - ",
                      "Kathmandu Durbar Square - 1.2 km for from you ",
                      "Green Valley Coconut Store",
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                      Icons.location_on_outlined,
                      color: buttonMainColor,
                      size: 22
                  ),
                  SizedBox(width: 5,),
                  pickupAndDileveryInfo(
                    "Delivery - ",
                    "Patan , Durbar Square - 3.5 km from the pickup location",
                    " John Doe",
                  ),
                ],
              ),
              SizedBox(height: 15,),

              SizedBox(
                width: double.maxFinite,
                child: CustomButton(title: "View order details", onPressed: (){
                  //Navigator.push(context, route);
                }),
              )
            ],
          ),
          )
        ],
      ),
    );
  }
  Expanded pickupAndDileveryInfo(title, address, subtitle){
    return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Text(
                      title, maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 15),
                    ),
                ),
                Expanded(
                  flex: 9,
                  child: Text(
                    address, maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(
                      fontWeight: FontWeight.w500,fontSize: 15),
                  ),
                ),

              ],
            ),
            Text(subtitle,style: TextStyle(color: Colors.black38),)
          ],
        ));
  }
}
