
import 'package:delivery_boy_app/utills/colors.dart';
import 'package:delivery_boy_app/widgets/dash_vertical.dart';
import 'package:flutter/material.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
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
                    Text("₹ 320",style: TextStyle(
                      fontSize: 16,
                      color: iconColor,
                      fontWeight: FontWeight.w600
                    ),),

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
                          Text(""),
                        ],
                      ))
                    ],
                  )
                ],
              ),
              ),
            )
          ],
        ),
      ),
    );

  }
}
