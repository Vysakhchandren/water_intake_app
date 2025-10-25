import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_intake_app/bars/bar_graph.dart';
import 'package:water_intake_app/provider/water_data.dart';
import 'package:water_intake_app/utils/date_helper.dart';

class WaterSummery extends StatelessWidget {
  final DateTime starttoWeek;

  const WaterSummery({super.key, required this.starttoWeek});

  @override
  Widget build(BuildContext context) {
    String sunday = convertDateTimeToString(starttoWeek.add(Duration(days: 0)));
    String monday = convertDateTimeToString(starttoWeek.add(Duration(days: 1)));
    String tuesday = convertDateTimeToString(
      starttoWeek.add(Duration(days: 2)),
    );
    String wednesday = convertDateTimeToString(
      starttoWeek.add(Duration(days: 3)),
    );
    String thursday = convertDateTimeToString(
      starttoWeek.add(Duration(days: 4)),
    );
    String friday = convertDateTimeToString(starttoWeek.add(Duration(days: 5)));
    String saturday = convertDateTimeToString(
      starttoWeek.add(Duration(days: 6)),
    );

    return Consumer<WaterData>(
      builder: (context, value, child) => SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: BarGraph(
            maxY: calculateMaxAmount(
              value,
              sunday,
              monday,
              tuesday,
              wednesday,
              thursday,
              friday,
              saturday,
            ),
            sunWaterAmt: value.calculateDailyWaterSummery()[sunday] ?? 0,
            monWaterAmt: value.calculateDailyWaterSummery()[monday] ?? 0,
            tueWaterAmt: value.calculateDailyWaterSummery()[tuesday] ?? 0,
            wedWaterAmt: value.calculateDailyWaterSummery()[wednesday] ?? 0,
            thuWaterAmt: value.calculateDailyWaterSummery()[thursday] ?? 0,
            friWaterAmt: value.calculateDailyWaterSummery()[friday] ?? 0,
            satWaterAmt: value.calculateDailyWaterSummery()[saturday] ?? 0,
          ),
        ),
      ),
    );
  }

  double calculateMaxAmount(
    WaterData waterData,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    double? maxAmount = 100;
    List<double> values = [
      waterData.calculateDailyWaterSummery()[sunday] ?? 0,
      waterData.calculateDailyWaterSummery()[monday] ?? 0,
      waterData.calculateDailyWaterSummery()[tuesday] ?? 0,
      waterData.calculateDailyWaterSummery()[wednesday] ?? 0,
      waterData.calculateDailyWaterSummery()[thursday] ?? 0,
      waterData.calculateDailyWaterSummery()[friday] ?? 0,
      waterData.calculateDailyWaterSummery()[saturday] ?? 0,
    ];

    values.sort();
    maxAmount = values.last * 1.3;
    return maxAmount == 0 ? 100 : maxAmount;
  }
}
