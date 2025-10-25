import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_intake_app/bars/bar_graph.dart';
import 'package:water_intake_app/provider/water_data.dart';

class WaterSummery extends StatelessWidget {
  final DateTime starttoWeek;

  const WaterSummery({super.key, required this.starttoWeek});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<WaterData>(
      builder: (context, value, child) => SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: BarGraph(
            maxY: 100,
            sunWaterAmt: 93,
            monWaterAmt: 34,
            tueWaterAmt: 07,
            wedWaterAmt: 45,
            thuWaterAmt: 46,
            friWaterAmt: 88,
            satWaterAmt: 6,
          ),
        ),
      ),
    );
  }
}
