import 'package:flutter/material.dart';
import 'package:water_intake_app/provider/water_data.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(

      create: (context) => WaterData(),

      child: MaterialApp(
        title: 'Water Intake',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange ),
        ),
        home: const HomePage(),
      ),
    );
  }
}




