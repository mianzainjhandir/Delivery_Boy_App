
import 'package:delivery_boy_app/provider/delivery_provider.dart';
import 'package:delivery_boy_app/utills/colors.dart';
import 'package:delivery_boy_app/widgets/custom_button.dart';
import 'package:delivery_boy_app/widgets/dash_vertical.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:provider/provider.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
          title: Text("Order Detail"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(top: 12,left: 20),
                  child: Text("Customer Information",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHXp6hNlS__xEdy7cVsi_Q9ctwW74eL8oXRA&s"),

                    ),
                    title: Text("John Doe",style: TextStyle(
                      fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),),
                    subtitle: Text("Delivery * 1234567890",style: TextStyle(
                        color: Colors.grey[600]
                    ),),
                    trailing: CircleAvatar(
                      backgroundColor: iconColor,
                      child: Icon(Icons.phone,color: Colors.white,),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 18,),
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              child: Padding(padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Order Summery",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black
                  ),),
                  SizedBox(height: 7,),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY1yjOaz-ncmlmm6Dqr1jg45dlJ4rbwut66Q&s"
                        ,height: 50,width: 50,
                        fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 5,),
                      Text.rich(
                        TextSpan(style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                        children: [
                          TextSpan(text: "Tender Coconut {Normal}"),
                          TextSpan(text: " * 4",style: TextStyle(color: Colors.black38))

                        ]
                        )
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(children: [
                    Icon(Icons.credit_card_outlined),
                    SizedBox(width: 10,),
                    Text("₹320",style: TextStyle(
                      fontSize: 16,
                      color: iconColor,
                      fontWeight: FontWeight.w600
                    ),),
                    SizedBox(width: 10,), Icon(Icons.check_circle_sharp, color: iconColor,),SizedBox(width: 10,),
                    Text("Paid",style: TextStyle(
                      color: iconColor,
                      fontWeight: FontWeight.w600
                    ),)

                  ],)

                ],
              ),
              ),
            ),
            SizedBox(height: 12,),
            //Pick up and delivery location
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.radio_button_checked,
                          color: Colors.black26,
                            size: 20,
                          ),
                          SizedBox(height: 80,
                          child: DashVerticalLine(
                            dashHeight: 5,
                            dashGap: 5,
                          ),
                          ),
                        ],
                      ),
                      SizedBox(width: 12,),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("PickUp Location", style: TextStyle(color: Colors.black26,fontWeight: FontWeight.w600,fontSize: 16),),
                          SizedBox(height: 2,),
                          Text("Cathmandu Darbar Square",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16),),
                          SizedBox(height: 2,),
                          Text("Green Velly Coconut *145826522",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600,fontSize: 16),),
                        ],
                      )
                      ),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: iconColor,
                        child: Icon(Icons.phone,color: Colors.white,size: 18,),
                      ),
                      SizedBox(width: 20,),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.red.shade50,
                        child: Transform.rotate(angle:  -pi / 4,child: Icon(Icons.send,size: 18,color: buttonMainColor,),),
                      )
                    ],
                  ),
                  SizedBox(height: 12,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: buttonMainColor,
                        size: 22,
                      ),
                      SizedBox(width: 12,),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Delivery Location",style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),),
                          SizedBox(height: 2,),
                          Text("Patan Durbar Square,\n 11000, Nepal",style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: Colors.black
                          ),),
                          SizedBox(height: 2,),
                          Text("John Doe ",style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey
                          ),),

                        ],
                      )),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.red.shade50,
                        child: Transform.rotate(angle:  -pi / 4,child: Icon(Icons.send,size: 18,color: buttonMainColor,),)

                      )
                    ],
                  )
                ],
              ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Consumer<DeliveryProvider>(
          builder: (context, provider, child){
        return Container(
          color: Colors.white,
          child: Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
            child:
            provider.status == DeliveryStatus.orderAccepted ? CustomButton(title: "Start Pickup", onPressed: (){
              context.read<DeliveryProvider>().startPickup();
            })
            : Row(
            children: [
              Expanded(
                  child: CustomButton(
                    color: declineOrder,
                    textColor: Colors.black54,
                    title: "Decline Order", onPressed: (){
                    context.read<DeliveryProvider>().rejectOrder();
                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Order is not accepted"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
              )
              ),
              SizedBox(width: 10,),
              Expanded(
                  child: CustomButton(
                    title: "Accept Order ", onPressed: (){
                      context.read<DeliveryProvider>().acceptOrder();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Order is accepted"),
                          backgroundColor: Colors.green,
                        ),
                      );
                  },
                  )
              ),
            ],
          ),),
        );
      }),
    );

  }
}

