import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Services/ShiftProvider.dart';

class SeeShifts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("See Shifts")),
      body: Consumer<ShiftProvider>(
        builder: (context, shiftProvider, child) {
          return shiftProvider.shifts.isEmpty
              ? Center(child: Text("No shifts assigned yet."))
              : ListView.builder(
            itemCount: shiftProvider.shifts.length,
            itemBuilder: (context, index) {
              final shift = shiftProvider.shifts[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text("${shift.cleaner} - ${shift.location}"),
                  subtitle: Text(
                    "Date: ${shift.date}\nTime: ${shift.time}\nDescription: ${shift.description}",
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
