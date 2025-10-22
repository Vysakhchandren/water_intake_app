import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:water_intake_app/provider/water_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final amountController = TextEditingController();



  void addWater() {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Add Water'),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Add water to your daily intake'),
                const SizedBox(height: 10),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Amount',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () {
                Navigator.pop(context);
              }, child: Text('Cancel')),
              TextButton(onPressed: () {
                //save to db
                //saveWater(amountController.text);

              }, child: Text('Save')),

            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WaterData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text('Water '),
          centerTitle: true,
          elevation: 4.0,
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
        ),
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .onSurfaceVariant,
        floatingActionButton: FloatingActionButton(
          onPressed: addWater,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
