
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
          ),
          // Delivery location row with icon text and phone icon

          ListTile(leading: Icon(_getDeliveryIcon(), color: _getDeliveryIconColor(),),
          title: Text("Delivery -${order.customerName}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
            subtitle: Text(order.deliveryAddress),
            trailing: CircleAvatar(
              radius: 18,
              backgroundColor: iconColor,
                child: Icon(Icons.phone,color: Colors.white,),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: SizedBox(width: double.maxFinite,child: ,),
          )
        ],
    ),
    );
  }
  // return appropriate button widget based on the delivery status
  // differences button type for mark as destination and same button style for remaining status
  Widget _buttonStyle() {
    switch(status) {
      case DeliveryStatus.destinationReached:
        return Padding(padding: EdgeInsets.symmetric(horizontal: 18),
        child: GestureDetector(
          onTap: _isButtonEnabled() ? (onButtonPressed ?? (){}) : (){},
          child: Row(
            children: [
              Expanded(child: Container(

              ))
            ],
          ),
        ),
        );
    }
  }
// return button color on based on delivery status
  Color _getButtonColor() {
    switch(status) {

      case DeliveryStatus.pickingUp:
        return pickedUpColor;
      case DeliveryStatus.enRoute:
        return Colors.orange.withAlpha(150);
      case DeliveryStatus.destinationReached:
        return pickedUpColor;
      case DeliveryStatus.markingAsDelivered:
        return buttonMainColor;
      case DeliveryStatus.delivered:
        return Colors.red.withAlpha(150);
      default:
        return buttonMainColor;
    }
  }

  String _getButtonTitle() {
    switch(status) {
      case DeliveryStatus.pickingUp:
        return "Mark as Picked Up";
      case DeliveryStatus.enRoute:
        return "Delivering...";
      case DeliveryStatus.destinationReached:
        return "Marked as destination reached";
      case DeliveryStatus.markingAsDelivered:
        return "Mark as Delivered";
      case DeliveryStatus.delivered:
        return "Marking as delivered...";
      default:
        return "Start Pickup";
    }
  }

  bool _isButtonEnabled() {
    switch(status) {
      case DeliveryStatus.enRoute:
      case DeliveryStatus.delivered:
        return false;
      default:
        return true;
    }
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
  // return appropriate icon for delivery location based on status
   IconData _getDeliveryIcon() {
    switch (status) {
      case DeliveryStatus.markingAsDelivered:
      case DeliveryStatus.delivered:
      // check only if the delivery is marked as delivered
        return Icons.check_circle;
      default:
        return Icons.location_on_outlined;
    }
   }
   // return color for delivery location icon based on status
   Color _getDeliveryIconColor() {
    switch(status){
      case DeliveryStatus.markingAsDelivered:
      case DeliveryStatus.delivered:
        return buttonMainColor;
      default:
        return Colors.red;
    }
   }
}