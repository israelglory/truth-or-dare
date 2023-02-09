import 'package:t_or_d/features/play_physical/wheel_view/wheel_view.dart';
import 'package:t_or_d/routes/exports.dart';

class AddPlayersController extends GetxController {
  TextEditingController playerNameController = TextEditingController();
  List<String> players = [];

  void addPlayer() {
    if (playerNameController.text.isNotEmpty) {
      players.add(playerNameController.text);
      playerNameController.clear();
      update();
    } else {
      Get.snackbar('Error', 'Please Enter a name',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          isDismissible: true);
    }
  }

  void removePlayer(int index) {
    players.removeAt(index);
    print('removed');
    update();
  }

  void onContinue() {
    if (players.length < 2) {
      Get.snackbar(
        'Error',
        'Please Add more than one player',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        isDismissible: true,
      );
    } else {
      Get.to(() => const WheelView(), arguments: players);
      print('Done');
    }
  }
}
