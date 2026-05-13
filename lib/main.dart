import 'package:delivery_boy_app/provider/current_location_provider.dart';
import 'package:delivery_boy_app/screens/app_main_screen.dart';
import 'package:delivery_boy_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CurrentLocationProvider()),
      ],
      child: MaterialApp(
        title: 'Delivery Boy App',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}