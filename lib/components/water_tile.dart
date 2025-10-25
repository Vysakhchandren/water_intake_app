import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_intake_app/model/water_mode.dart';
import 'package:water_intake_app/provider/water_data.dart';

class WaterTile extends StatelessWidget {
  const WaterTile({super.key, required this.waterModel});

  final WaterModel waterModel;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      elevation: 4,
      child: ListTile(
        title: Row(
          children: [
            Icon(Icons.water_drop, size: 20, color: Colors.blue),
            Text('${waterModel.amount.toStringAsFixed(2)} ml'),
          ],
        ),
        subtitle: Text(
          '${waterModel.dateTime.day} /${waterModel.dateTime.month}',),
          trailing: IconButton( onPressed: () {
            Provider.of<WaterData>(context, listen: false).delete(waterModel);
          }, icon: Icon(Icons.delete),)

      ),
    );
  }
}
