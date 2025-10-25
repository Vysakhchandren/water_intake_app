import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:water_intake_app/model/water_mode.dart';

import '../utils/date_helper.dart';

class WaterData extends ChangeNotifier {
  List<WaterModel> waterDataList = [];

  //add water
  void addWater(WaterModel water) async {
    final url = Uri.https(
      "water-intaker-597a0-default-rtdb.firebaseio.com",
      "water.json",
    );

    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'amount': double.parse(water.amount.toString()),
        'unit': 'ml',
        'dateTime': DateTime.now().toString(),
      }),
    );

    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      waterDataList.add(
        WaterModel(
          id: extractedData['name'],
          amount: water.amount,
          dateTime: water.dateTime,
          unit: 'ml',
        ),
      );
    } else {
      print('Error: ${response.statusCode}');
    }
    notifyListeners();
  }

  Future<List<WaterModel>> getWater() async {
    final url = Uri.https(
      "water-intaker-597a0-default-rtdb.firebaseio.com",
      "water.json",
    );
    final response = await http.get(url);
    if (response.statusCode == 200 && response.body != 'null') {
      waterDataList.clear();

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      for (var element in extractedData.entries) {
        waterDataList.add(
          WaterModel(
            id: element.key,
            amount: element.value['amount'],
            dateTime: DateTime.parse(element.value['dateTime']),
            unit: element.value['unit'],
          ),
        );
      }
    }

    notifyListeners();
    return waterDataList;
  }

  String getWeekday(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

  DateTime getStartOfWeek() {
    DateTime? startOfWeek;
    DateTime dateTime = DateTime.now();

    for (int i = 0; i < 7; i++) {
      if (getWeekday(dateTime.subtract(Duration(days: i))) == 'Sunday') {
        startOfWeek = dateTime.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  void delete(WaterModel waterModel) {
    final url = Uri.https(
      "water-intaker-597a0-default-rtdb.firebaseio.com",
      "water/${waterModel.id}.json",
    );
    http.delete(url);
    //remove item from the list
    waterDataList.removeWhere((element) => element.id == waterModel.id!);
    notifyListeners();
  }

  String calculateTotalWaterIntake(WaterData value) {
    double weeklyWaterIntake = 0;

    for (var water in value.waterDataList) {
      weeklyWaterIntake += double.parse(water.amount.toString());
    }
    return weeklyWaterIntake.toStringAsFixed(2);
  }

  // calculate the daily water intake
  Map<String, double> calculateDailyWaterSummery() {
    Map<String, double> dailyWaterSummery = {};

    //loop through the water data list
    for (var water in waterDataList) {
      String date = convertDateTimeToString(water.dateTime);
      double amount = double.parse(water.toString());
      if (dailyWaterSummery.containsKey(date)) {
        double currentAmount = dailyWaterSummery[date]!;
        currentAmount += amount;
        dailyWaterSummery[date] = currentAmount;
        } else {
        dailyWaterSummery.addAll({date : amount});
      }
    }
    return dailyWaterSummery;
  }
}
