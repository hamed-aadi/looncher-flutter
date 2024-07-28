import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AlarmsModel extends ChangeNotifier {
  AlarmsModel() {
    getAlarm();
  }

  final alarmsChannel = const MethodChannel('com.hamedaadi.looncher/alarms');
  String? remainingTime;
  
  Future<void> getAlarm() async {
    int? timeUTC = await alarmsChannel.invokeMethod("getAlarm");
    updateRemainingTime(timeUTC);
  }
  
  void updateRemainingTime(int? timeUTC) {
    if (timeUTC == null) {
      remainingTime = "No Alarm is set";
    } else {
      var alarmTime = DateTime.fromMillisecondsSinceEpoch(timeUTC);
      Duration diffTime = alarmTime.difference(DateTime.now());
      remainingTime =
      "Alarm in ${diffTime.inHours}H ${diffTime.inMinutes % 60}M";
    }
    notifyListeners();
  }
  
}
