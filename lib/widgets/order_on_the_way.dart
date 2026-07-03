
import 'package:delivery_boy_app/utills/colors.dart';
import 'package:flutter/material.dart';

import '../model/order.dart';
import '../provider/delivery_provider.dart';


class OrderOnTheWay extends StatelessWidget {
  final OrderModel order;
  final DeliveryStatus status;
  final VoidCallback? onButtonPressed;
  const OrderOnTheWay({
    super.key,
    required this.order,
    required this.status,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ), // BoxDecoration
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10,),
          Container(
            height: 5,width: 40, decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.black26,
          ),
          ),
          ListTile(
            leading: Icon(_getPickupIcon(), color: _getPickupIconColor(),),
            title: Text("Pickup Location",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
            subtitle: Text(order.pickupAddress),
            trailing: CircleAvatar(
              radius: 18,
              backgroundColor: iconColor,
              child: Icon(Icons.phone,color: Colors.white,),
            ),
          )
        ],
        // Delivery location row with icon text and phone icon

    ),
    );
  }
  IconData _getPickupIcon() {
    switch (status) {
      case DeliveryStatus.enRoute:
      case DeliveryStatus.destinationReached:
      case DeliveryStatus.markingAsDelivered:
      case DeliveryStatus.delivered:
        return Icons.check_circle;
      default:
        return Icons.radio_button_checked;
    }
  }

  Color _getPickupIconColor() {
    switch (status) {
      case DeliveryStatus.enRoute:
      case DeliveryStatus.destinationReached:
      case DeliveryStatus.markingAsDelivered:
      case DeliveryStatus.delivered:
        return buttonMainColor;
      default:
        return Colors.grey;
    }
  }
}