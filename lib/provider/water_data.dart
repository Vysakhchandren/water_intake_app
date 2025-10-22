import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:water_intake_app/model/water_mode.dart';

class WaterData extends ChangeNotifier{
  List<WaterModel> waterDataList = [];
  //add water
  void saveWater(WaterModel water) async {
    final url = Uri.https(
        "water-intaker-597a0-default-rtdb.firebaseio.com",
        "water.json");

    var response = await http.post(url, headers: {
      'Content-Type': 'application/json'
    }, body:
    json.encode({
      'amount': double.parse(water.amount.toString()),
      'unit': 'ml',
      'dateTime': DateTime.now().toString()
    }));
   notifyListeners();
  }

}