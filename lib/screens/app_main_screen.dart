
import 'package:delivery_boy_app/screens/driver_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utills/colors.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  final List<Widget> pages = [
    DriverHomeScreen(),
    Center(child: Text('Order'),),
    Center(child: Text('Shipment'),),
    Center(child: Text('Profile'),),
  ];



  int _currentIndex = 0;
  final List<FaIconData> _icons = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.boxOpen,
    FontAwesomeIcons.truckFast,
    FontAwesomeIcons.solidCircleUser,
  ];

  final List<String> _labels = [
    "House","Orders","Shipment","Profile"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(top: 10, bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, -1),
            )
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:
            List.generate(_icons.length, (index){
              final bool isSelected = _currentIndex == index;
              return GestureDetector(
                onTap: (){
                  setState(() {
                    _currentIndex = index;
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 6),
                      decoration: isSelected ? BoxDecoration(
                          color: buttonSecondaryColor,
                          borderRadius: BorderRadius.circular(15),
                      ) : null,
                      child: FaIcon(
                        _icons[index],
                        size: 18,
                        color: isSelected ? buttonMainColor : Colors.black,

                      ),
                    ),
                    Text(
                      _labels[index],
                      style: TextStyle(
                        color: isSelected ? buttonMainColor : Colors.black,
                      ),
                    )
                  ],
                ),
              );
            })
        ),
      ),
    );
  }
}
