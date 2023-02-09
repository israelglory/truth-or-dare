import 'dart:async';
import 'dart:math';

import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:t_or_d/routes/exports.dart';

class WheelViewModel extends GetxController {
  StreamController<int> controller = StreamController<int>();
  List<String> players = Get.arguments as List<String>;
  double generateRandomAngle() => Random().nextDouble() * pi * 2;

  void ontap() {
    controller.add(
      Fortune.randomInt(0, players.length),
    );
    //print(controller.stream.first.asStream());
    notifyChildrens();
  }
}
